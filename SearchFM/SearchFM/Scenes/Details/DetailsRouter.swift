//
//  DetailsRouter.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//


import UIKit

@objc protocol DetailsRoutingLogic
{
    func routeToNextVC()
}

protocol DetailsDataPassing
{
    var dataStore: DetailsDataStore? { get }
}

class DetailsRouter: NSObject, DetailsRoutingLogic, DetailsDataPassing
{
    weak var viewController: DetailsViewController?
    var dataStore: DetailsDataStore?
    
    // MARK: Routing
    
    func routeToNextVC()
    {
    }
}
