//
//  DetailsWorker.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//


import UIKit

class DetailsWorker
{
    func getDetail(request: Details.Fetch.Request?, _ onCompletion: @escaping CompletionHandler) {
        
        NetworkHttpClient.sharedInstance.performAPICall(request?.url, parameters: request?.params, success: { (dataResponse) in
            onCompletion(true, dataResponse)
        }) { (error) in
            print(error as Any)
            onCompletion(false, error)
        }
    }
}
