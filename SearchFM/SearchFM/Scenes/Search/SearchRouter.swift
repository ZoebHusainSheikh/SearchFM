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
    
    func routeToDetails()
    {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let destinationVC = storyboard.instantiateViewController(withIdentifier: DetailsViewController.className) as! DetailsViewController
        var destinationDS = destinationVC.router!.dataStore!
        passDataToDetails(source: dataStore!, destination: &destinationDS)
        navigateToDetails(source: viewController!, destination: destinationVC)
    }
    
    // MARK: Navigation
    
    func navigateToDetails(source: SearchViewController, destination: DetailsViewController)
    {
        source.show(destination, sender: nil)
    }
    
    // MARK: Passing data
    
    func passDataToDetails(source: SearchDataStore, destination: inout DetailsDataStore)
    {
        destination.record = source.record
    }
}
