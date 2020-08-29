//
//  SearchPresenterTests.swift
//  SearchFMTests
//
//  Created by mymac on 29/08/20.
//

import XCTest

class SearchPresenterTests: XCTestCase {
    class MockSearchPresenter: SearchPresenter {
        override func present(response: Search.Fetch.Response) {
            self.viewController?.display(viewModel: Search.Fetch.ViewModel())
            self.viewController?.stopAnimation()
        }
    }
    // MARK: Subject under test
    
    var sut: MockSearchPresenter!
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        setupSearchPresenter()
    }
    
    override func tearDown()
    {
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupSearchPresenter()
    {
        sut = MockSearchPresenter()
    }
    
    // MARK: Test doubles
    
    class SearchDisplayLogicSpy: SearchDisplayLogic
    {
        
        var displaySearchCalled = false
        func display(viewModel: Search.Fetch.ViewModel) {
            displaySearchCalled = true
        }
        
        var stopAnimationCalled = false
        func stopAnimation() {
            stopAnimationCalled = true
        }
    }
    
    // MARK: Tests
    
    func testPresentSearch()
    {
        // Given
        let spy = SearchDisplayLogicSpy()
        sut.viewController = spy
        let response = Search.Fetch.Response(data: nil)
        
        // When
        sut.present(response: response)
        
        // Then
        XCTAssertTrue(spy.displaySearchCalled, "present(response:) should ask the view controller to display the result")
    }
    
    func testStopAnimations()
    {
        // Given
        let spy = SearchDisplayLogicSpy()
        sut.viewController = spy
        let response = Search.Fetch.Response(data: nil)
        
        // When
        sut.present(response: response)
        
        // Then
        XCTAssertTrue(spy.stopAnimationCalled, "present(response:) should ask the view controller to stop the animation")
    }
}
