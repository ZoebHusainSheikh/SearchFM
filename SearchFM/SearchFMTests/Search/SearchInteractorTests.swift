//
//  SearchInteractorTests.swift
//  SearchFMTests
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//

import XCTest

class SearchInteractorTests: XCTestCase {
    class MockSearchInteractor: SearchInteractor {
        override func fetch(request: Search.Fetch.Request) {
            let response = Search.Fetch.Response(data: nil)
            self.presenter?.present(response: response)
        }
    }
    
    // MARK: Subject under test
    
    var sut: MockSearchInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupSearchInteractor()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupSearchInteractor()
    {
        sut = MockSearchInteractor()
    }
    
    // MARK: Test doubles
    
    class SearchPresentationLogicSpy: SearchPresentationLogic
    {
        var presentRecordssCalled = false
        
        func present(response: Search.Fetch.Response) {
            presentRecordssCalled = true
        }
    }
    
    // MARK: Tests
    
    func testFetchRequest()
    {
        // Given
        let spy = SearchPresentationLogicSpy()
        sut.presenter = spy
        let request = Search.Fetch.Request(url: "")
        
        // When
        sut.fetch(request: request)
        
        // Then
        XCTAssertTrue(spy.presentRecordssCalled, "fetch(request:) should ask the presenter to format the result")
    }
}
