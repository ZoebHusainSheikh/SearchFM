//
//  DetailsInteractor.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//


import UIKit

protocol DetailsBusinessLogic
{
    var record: Record? { get set }
}

class DetailsInteractor: DetailsBusinessLogic
{
    var record: Record?
}
