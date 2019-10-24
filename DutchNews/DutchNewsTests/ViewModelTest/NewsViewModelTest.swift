//
//  NewsViewModelTest.swift
//  DutchNewsTests
//
//  Created by Abdorahman Youssef on 7/19/19.
//  Copyright © 2019 abdelrahman. All rights reserved.
//

import XCTest
import RxSwift
@testable import DutchNews

class NewsViewModelTest: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testNormalCells(){
        let disposeBag = DisposeBag()
        let mockAPIClient = MockAPI()
        mockAPIClient.expectedResults = .success(payload: NewsModel.with(status: "ok", totalResults: 40, numberOfArticles: 20))
        
        let viewModel = NewsViewModel.init(apiProvider: mockAPIClient)
        viewModel.fetchNews()
        
        let expectNormalCellsCreated = expectation(description: "News table contains normal cells")
        
        viewModel.cells.subscribe(
            onNext: {
                let lastCellIsNormal: Bool
                
                if case .some(.normal(_)) = $0.last{
                    lastCellIsNormal = true
                }else {
                    lastCellIsNormal = false
                }
                XCTAssertTrue(lastCellIsNormal)
                expectNormalCellsCreated.fulfill()
                
        }).disposed(by: disposeBag)
        
        wait(for: [expectNormalCellsCreated], timeout: 0.1)
    }

    
    func testEmptyNews(){
        let disposeBag = DisposeBag()
        let mockAPIClient = MockAPI()
        mockAPIClient.expectedResults = .success(payload: NewsModel.with(status: "ok", totalResults: 0, numberOfArticles: 0))
        
        let viewModel = NewsViewModel.init(apiProvider: mockAPIClient)
        viewModel.fetchNews()
        
        let expectEmptyCellCreated = expectation(description: "News table contains an empty cell")
        
        viewModel.cells.subscribe(
            onNext: {
                let firstCellIsEmpty: Bool
                
                if case .some(.empty) = $0.first{
                    firstCellIsEmpty = true
                }else {
                    firstCellIsEmpty = false
                }
                
                XCTAssertTrue(firstCellIsEmpty)
                expectEmptyCellCreated.fulfill()
                
        }).disposed(by: disposeBag)
        
        wait(for: [expectEmptyCellCreated], timeout: 0.1)
    }
    
    func testErrorNews(){
        
        let disposeBag = DisposeBag()
        let mockAPIClient = MockAPI()
        mockAPIClient.expectedResults = .failure(ErrorCase.internalServerError)
        
        let viewModel = NewsViewModel.init(apiProvider: mockAPIClient)
        viewModel.fetchNews()
        
        let expectErrorCellCreated = expectation(description: "News table contains an error cell")
        
        viewModel.cells.subscribe(
            onNext: {
                let firstCellIsEmpty: Bool
                
                if case .some(.error) = $0.first{
                    firstCellIsEmpty = true
                }else {
                    firstCellIsEmpty = false
                }
                
                XCTAssertTrue(firstCellIsEmpty)
                expectErrorCellCreated.fulfill()
                
        }).disposed(by: disposeBag)
        
        wait(for: [expectErrorCellCreated], timeout: 0.1)
    }
}
