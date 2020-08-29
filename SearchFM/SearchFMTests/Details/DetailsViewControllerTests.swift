//
//  DetailsViewControllerTests.swift
//  SearchFMTests
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//

import XCTest

class DetailsViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: DetailsViewController!
    var window: UIWindow!
    var mockRecords: [Record] {
        let record = Record()
        record.name = "Making Music"
        record.url = "https://www.last.fm/musi…kir+Hussain/Making+Music"
        record.images = [["#text": "https://lastfm.freetls.fastly.net/i/u/34s/03431be7806f4bb78cf7ee6991cc5647.png"]]
        
        return [record]
    }
    
    // MARK: Test lifecycle
    
    override func setUp()
    {
        super.setUp()
        window = UIWindow()
        setupDetailsViewController()
    }
    
    override func tearDown()
    {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupDetailsViewController()
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        sut = storyboard.instantiateViewController(withIdentifier: DetailsViewController.className) as? DetailsViewController
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test
    
    class DetailsBusinessLogicSpy: DetailsBusinessLogic
    {
        var displayRecordsCalled = false
        
        func display(record: Record) {
            displayRecordsCalled = true
        }
        
        var record: Record?
    }
    
    // MARK: Tests
    
    func testShouldDisplayRecords()
    {
        // Given
        let spy = DetailsBusinessLogicSpy()
        sut.interactor = spy
        sut.interactor?.record = mockRecords.first
        
        // When
        loadView()
        
        // Then
        XCTAssertTrue(spy.displayRecordsCalled, "viewDidLoad() should ask the interactor to display records")
    }
    
    func testDisplayRecordDetails()
    {
        // Given
        let record = mockRecords.first!
        
        // When
        loadView()
        sut.display(record:record)
        
        // Then
        XCTAssertEqual(sut.nameLabel.text, "Making Music", "viewDidLoad() should update the name label text")
    }
}
