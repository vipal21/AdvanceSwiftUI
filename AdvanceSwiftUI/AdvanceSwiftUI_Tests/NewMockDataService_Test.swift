//
//  NewMockDataService_Test.swift
//  AdvanceSwiftUI_Tests
//
//  Created by Vipal on 21/10/22.
//

import XCTest
@testable import AdvanceSwiftUI
import Combine

final class NewMockDataService_Test: XCTestCase {
    var cancellable  = Set<AnyCancellable>()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        cancellable.removeAll()
    }

    func test_newMoeckDataService_init_doesSetValueCorrectly(){
        //Given
        let items :[String]? = nil
        let items1 :[String]? = []
        let items2 :[String]? = [
            UUID().uuidString,
            UUID().uuidString
        ]
        //When
        let dataService = NewMoeckDataService(items: items)
        let dataService1 = NewMoeckDataService(items: items1)
        let dataService2 = NewMoeckDataService(items: items2)
        //Then
        XCTAssertNotNil(dataService.items)
        XCTAssertTrue(dataService1.items.isEmpty)
        XCTAssertEqual(dataService2.items.count,items2?.count)
    }
    func test_newMoeckDataService_downloadItemWithEscaping_doesreturnVslue(){
        //Given
        let dataservice = NewMoeckDataService(items: nil)
        //When
        var newItems : [String] = []
        let expectation :XCTestExpectation = XCTestExpectation()
        dataservice.downloadItemWithEscaping { items in
            newItems = items
            expectation.fulfill()
        }
        //Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(newItems.count, dataservice.items.count)
    }

    func test_NewMockDataService_downloadItemsWithCombine_doesReturnValues() {
        // Given
        let dataService = NewMoeckDataService(items: nil)

        // When
        var items: [String] = []
        let expectation = XCTestExpectation()
        
        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    expectation.fulfill()
                case .failure:
                    XCTFail()
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellable)

        // Then
        wait(for: [expectation], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
    func test_NewMockDataService_downloadItemsWithCombine_doesFail() {
        // Given
        let dataService = NewMoeckDataService(items: [])

        // When
        var items: [String] = []
        let expectation = XCTestExpectation(description: "Does throw an error")
        let expectation2 = XCTestExpectation(description: "Does throw URLError.badServerResponse")

        dataService.downloadItemsWithCombine()
            .sink { completion in
                switch completion {
                case .finished:
                    XCTFail()
                case .failure(let error):
                    expectation.fulfill()
                    
                    //let urlError = error as? URLError
                    //XCTAssertEqual(urlError, URLError(.badServerResponse))
                    
                    if error as? URLError == URLError(.badServerResponse) {
                        expectation2.fulfill()
                    }
                }
            } receiveValue: { returnedItems in
                items = returnedItems
            }
            .store(in: &cancellable)

        // Then
        wait(for: [expectation, expectation2], timeout: 5)
        XCTAssertEqual(items.count, dataService.items.count)
    }
}
