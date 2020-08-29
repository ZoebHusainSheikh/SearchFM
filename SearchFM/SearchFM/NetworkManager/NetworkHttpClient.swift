//
//  NetworkHttpClient.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//

import UIKit
import Foundation

typealias CompletionHandler = (_ success: Bool, _ response: Any?) -> Void

class NetworkHttpClient: NSObject {
    
    static let getMethod:String = "GET"
    
    typealias successBlock = (_ response: Data) -> Void
    typealias failureBlock = (_ response: Error?) -> Void
    
    static let sharedInstance = NetworkHttpClient()
}

extension NetworkHttpClient {
    
    func performAPICall(_ strURL : String?, method: String? = getMethod, parameters : Dictionary<String, Any>?, success:@escaping successBlock, failure:@escaping failureBlock){
        if let urlPath: String = strURL {
            
            guard let url = URL(string: urlPath) else { return }
            var request = URLRequest(url:url)
            request.httpMethod = method
            
            
            if let parameters = parameters {
                debugPrint("parameters: " + parameters.description)
                 var  jsonData = NSData()
                do {
                    jsonData = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted) as NSData
                    // you can now cast it with the right type
                } catch {
                    print(error.localizedDescription)
                }
                request.setValue("\(jsonData.length)", forHTTPHeaderField: "Content-Length")
                request.setValue("application/json", forHTTPHeaderField: "Content-Type")
                request.httpBody = jsonData as Data
            }
            
            let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
                self.parseResponse(success: success, failure: failure, data: data, response: response, error: error)
            }
            task.resume()
        }
    }
    
    func parseResponse(success: successBlock, failure: failureBlock, data: Data?, response: URLResponse?, error: Error?) {
        guard let dataResponse = data,
            error == nil else {
                debugPrint(error?.localizedDescription ?? "Response Error")
                failure(error)
                AlertViewController.sharedInstance.alertWindow(message: error?.localizedDescription ?? AlertViewController.kSomethingWentWrongMessage)
                return
        }
        
        if let parsedData = try? JSONSerialization.jsonObject(with: dataResponse) as? [String:Any] {
            debugPrint("Response: " + parsedData.debugDescription)
        }
        
        success(dataResponse)
    }
}
