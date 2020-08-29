//
//  DetailsInteractorTests.swift
//  SearchFMTests
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//

import XCTest

class DetailsInteractorTests: XCTestCase {
    
    class MockDetailsInteractor: DetailsInteractor {
        
        override func display(record: Record) {
            self.presenter?.present(record: record)
        }
    }
    
    // MARK: Subject under test
    
    var sut: MockDetailsInteractor!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupDetailsInteractor()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupDetailsInteractor()
    {
        sut = MockDetailsInteractor()
    }
    
    // MARK: Test
    
    class DetailsPresentationLogicSpy: DetailsPresentationLogic
    {
        var presentRecordCalled = false
        
        func present(record: Record) {
            presentRecordCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentRecord()
    {
        // Given
        let spy = DetailsPresentationLogicSpy()
        sut.presenter = spy
        let record = Record()
        
        // When
        sut.display(record: record)
        
        // Then
        XCTAssertTrue(spy.presentRecordCalled, "display(record:) should ask the presenter to display the result")
    }
}
