//
//  DetailsModels.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//


import UIKit

enum Details
{
    // MARK: Use cases
    
    enum Fetch
    {
        struct Request
        {
            let url: String!
            var params : Dictionary<String, Any>?
        }
        struct Response
        {
            let data: Data?
        }
        struct ViewModel
        {
            var record: Record?
        }
    }
}
