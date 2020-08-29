//
//  DetailsInteractor.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//


import UIKit

protocol DetailsBusinessLogic
{
    func display(record: Record)
    var record: Record? { get set }
}

class DetailsInteractor: DetailsBusinessLogic
{
    
    var record: Record?
    var presenter: DetailsPresentationLogic?
    
    // MARK: Display Record details
    func display(record: Record) {
        self.presenter?.present(record: record)
    }
    
}
