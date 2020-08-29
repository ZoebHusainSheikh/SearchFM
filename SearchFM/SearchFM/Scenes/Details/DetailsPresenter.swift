//
//  DetailsPresenter.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//


import UIKit

protocol DetailsPresentationLogic
{
    func presentDetails(response: Details.Fetch.Response)
    func refreshDetails()
}

class DetailsPresenter: DetailsPresentationLogic
{
    weak var viewController: DetailsDisplayLogic?
    
    // MARK: Present Contact Details
    
    func presentDetails(response: Details.Fetch.Response)
    {
        if let dataResponse:Data = response.data {
            do {
                //here dataResponse received from a network request
                let decoder = JSONDecoder()
                let model = try decoder.decode(Record.self, from:
                    dataResponse) //Decode JSON Response Data
                DispatchQueue.main.async { [weak self] in
                    self?.viewController?.displayDetails(viewModel: Details.Fetch.ViewModel(record: model))
                    self?.viewController?.stopAnimation()
                }
            } catch let parsingError {
                print("Error", parsingError)
                AlertViewController.sharedInstance.alertWindow(title: "Error", message: parsingError.localizedDescription)
            }
        } else {
            DispatchQueue.main.async { [weak self] in
                self?.viewController?.stopAnimation()
            }
        }
    }
    
    func refreshDetails() {
        viewController?.refreshDetails()
    }
}
