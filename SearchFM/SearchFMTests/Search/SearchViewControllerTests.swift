//
//  SearchViewControllerTests.swift
//  SearchFMTests
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//

import XCTest
import Search_FM

class SearchViewControllerTests: XCTestCase {
    // MARK: Subject under test
    
    var sut: SearchViewController!
    var window: UIWindow!
    var mockResults: Results {
        let results = Results()
        results.artistMatches = ArtistMatches()
        results.albumMatches = AlbumMatches()
        results.trackMatches = TrackMatches()
        results.artistMatches?.artists = mockRecords
        results.albumMatches?.albums = mockRecords
        results.trackMatches?.tracks = mockRecords
        
        return results
    }
    
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
        setupSearchViewController()
    }
    
    override func tearDown()
    {
        window = nil
        super.tearDown()
    }
    
    // MARK: Test setup
    
    func setupSearchViewController()
    {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: Bundle(for: type(of: self)))
        sut = storyboard.instantiateViewController(withIdentifier: SearchViewController.className) as? SearchViewController
    }
    
    func loadView()
    {
        window.addSubview(sut.view)
        RunLoop.current.run(until: Date())
    }
    
    // MARK: Test doubles
    
    class SearchBusinessLogicSpy: SearchBusinessLogic
    {
        var fetchRecordsCalled = false
        func fetch(request: Search.Fetch.Request) {
            fetchRecordsCalled = true
        }
        
        var record: Record?
    }
    
    // MARK: Tests
    
    func testShouldFetchRecords()
    {
        // Given
        let spy = SearchBusinessLogicSpy()
        sut.interactor = spy
        
        // When
        loadView()
        
        let searchBar = sut.searchBar
        searchBar?.text = "Test"
        sut.searchBarSearchButtonClicked(searchBar!)
        
        
        // Then
        XCTAssertTrue(spy.fetchRecordsCalled, "searchBarSearchButtonClicked() should ask the interactor to fetch records")
    }
    
    func testDisplayRecords()
    {
        // Given
        let viewModel = Search.Fetch.ViewModel(results: mockResults)
        
        // When
        loadView()
        sut.display(viewModel: viewModel)
        
        // Then
        XCTAssertEqual(sut.records?.count, 1, "displayRecords(viewModel:) should update the recordsWithSections count with 1 record")
    }
    
    func testDisplayRecordName()
    {
        // Given
        let viewModel = Search.Fetch.ViewModel(results: mockResults)
        
        // When
        loadView()
        sut.display(viewModel: viewModel)
        guard let records = sut.records as [Record]?, let record = records.first as Record? else {
            XCTFail("displayRecords(viewModel:) don't have any record")
            return
        }
        
        // Then
        XCTAssertEqual(record.name, "Making Music", "display(viewModel:) should have name 'Making Music'")
    }
    
    func testRecordCount()
    {
        // Given
        let viewModel = Search.Fetch.ViewModel(results: mockResults)
        
        // When
        loadView()
        sut.display(viewModel: viewModel)
        guard let records = sut.records as [Record]? else {
            XCTFail("displayRecords(viewModel:) don't have any record")
            return
        }
        
        // Then
        XCTAssertEqual(records.count, 1, "Results should have '1' Record")
    }
}
