//
//  DetailsPresenter.swift
//  SearchFM
//
//  Created by mymac on 29/08/20.
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
       self.viewController?.display(record: record)
    }
}
