//
//  DetailsViewControllerTests.swift
//  SearchFMTests
//
//  Created by mymac on 29/08/20.
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
    
    // MARK: Test doubles
    
    class DetailsBusinessLogicSpy: DetailsBusinessLogic
    {
        var record: Record?
    }
    
    // MARK: Tests
    
    func testDisplayRecordDetails()
    {
        // Given
        let spy = DetailsBusinessLogicSpy()
        sut.interactor = spy
        sut.interactor?.record = mockRecords.first
        
        // When
        loadView()
        
        // Then
        XCTAssertEqual(sut.nameLabel.text, "Making Music", "viewDidLoad() should update the name label text")
    }
}
