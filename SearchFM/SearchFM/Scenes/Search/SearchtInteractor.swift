//
//  SearchInteractor.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//


import UIKit

protocol SearchBusinessLogic
{
    func fetch(request: Search.Fetch.Request)
    var record: Record? { get set }
}

protocol SearchDataStore
{
    var record: Record? { get set }
}

class SearchInteractor: SearchBusinessLogic, SearchDataStore
{
    var record: Record?
    
    var presenter: SearchPresentationLogic?
    var worker = SearchWorker()
    
    // MARK: Fetch Records from API
    
    func fetch(request: Search.Fetch.Request)
    {
        worker.fetch(request: request, { (status, apiResponse) in
            
            let response = Search.Fetch.Response(data: apiResponse as? Data)
            self.presenter?.present(response: response)
        })
        
    }
}
