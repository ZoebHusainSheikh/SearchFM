//
//  DetailsPresenterTests.swift
//  SearchFMTests
//
//  Created by mymac on 29/08/20.
//

import XCTest

class DetailsPresenterTests: XCTestCase {
    class MockDetailsPresenter: DetailsPresenter {
        
        override func present(record: Record) {
            self.viewController?.display(record: record)
        }
    }
    // MARK: Subject under test
    
    var sut: MockDetailsPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupDetailsPresenter()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupDetailsPresenter()
    {
        sut = MockDetailsPresenter()
    }
    
    // MARK: Test doubles
    
    class DetailsDisplayLogicSpy: DetailsDisplayLogic
    {
        var displayDetailsCalled = false
        
        func display(record: Record) {
            displayDetailsCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentDetails()
    {
        // Given
        let spy = DetailsDisplayLogicSpy()
        sut.viewController = spy
        let record = Record()
        
        // When
        sut.present(record: record)
        
        // Then
        XCTAssertTrue(spy.displayDetailsCalled, "present(record:) should ask the view controller to display the result")
    }
}
