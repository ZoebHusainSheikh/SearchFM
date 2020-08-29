//
//  DetailsPresenter.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//

import UIKit

protocol DetailsPresentationLogic
{
    func present(record: Record)
}

class DetailsPresenter: DetailsPresentationLogic
{
    weak var viewController: DetailsDisplayLogic?
    
    // MARK: Mapping
    
    func present(record: Record)
    {
        DispatchQueue.main.async {
            self.viewController?.display(record: record)
        }
    }
}
