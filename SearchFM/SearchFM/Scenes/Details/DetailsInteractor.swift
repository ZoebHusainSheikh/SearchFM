//
//  DetailsInteractor.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//


import UIKit

protocol DetailsBusinessLogic
{
    func fetchDetails(request: Details.Fetch.Request)
    var record: Record? { get set }
}

protocol DetailsDataStore
{
    var record: Record? { get set }
}

class DetailsInteractor: DetailsBusinessLogic, DetailsDataStore
{
    var presenter: DetailsPresentationLogic?
    var worker: DetailsWorker?
    var record: Record?
    
    init() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.refreshRecord), name: Notification.Name("RefreshRecords"), object: nil)
    }
    
    // MARK: Fetch Record Details
    
    func fetchDetails(request: Details.Fetch.Request)
    {
        worker = DetailsWorker()
        worker?.getDetail(request: request, { (status, apiResponse) in
            
            let response = Details.Fetch.Response(data: apiResponse as? Data)
            self.presenter?.presentDetails(response: response)
        })
    }
    
    @objc func refreshRecord() {
        self.presenter?.refreshDetails()
    }
}
