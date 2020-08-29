//
//  SearchPresenter.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//


import UIKit

protocol SearchPresentationLogic
{
    func present(response: Search.Fetch.Response)
}

class SearchPresenter: SearchPresentationLogic
{
    weak var viewController: SearchDisplayLogic?
    
    // MARK: Mapping
    
    func present(response: Search.Fetch.Response)
    {
        if let dataResponse = response.data {
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model = try decoder.decode(SearchResponse.self, from:
                    dataResponse) //Decode JSON Response Data
                let records = model.results?.artistMatches?.artists
                self.viewController?.display(viewModel: Search.Fetch.ViewModel(records: records))
                self.viewController?.stopAnimation()
            } catch let parsingError {
                print("Error", parsingError)
                self.viewController?.stopAnimation()
                AlertViewController.sharedInstance.alertWindow(message: parsingError.localizedDescription)
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.viewController?.stopAnimation()
            }
        }
    }
}
