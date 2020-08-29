//
//  SearchRouter.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//


import UIKit

@objc protocol SearchRoutingLogic
{
    func routeToDetails()
}

protocol SearchDataPassing
{
    var dataStore: SearchDataStore? { get }
}

class SearchRouter: NSObject, SearchRoutingLogic, SearchDataPassing
{
    weak var viewController: SearchViewController?
    var dataStore: SearchDataStore?
    
    // MARK: Routing
    
    func routeToDetails() {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        var destinationVC = storyboard.instantiateViewController(withIdentifier: DetailsViewController.className) as! DetailsViewController
        passDataToDetails(source: dataStore!, destination: &destinationVC)
        navigateToDetails(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToDetails(source: SearchViewController, destination: DetailsViewController)
    {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToDetails(source: SearchDataStore, destination: inout DetailsViewController) {
        destination.interactor?.record = source.record
    }
}
