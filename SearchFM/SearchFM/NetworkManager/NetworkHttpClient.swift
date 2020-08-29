//
//  NetworkHttpClient.swift
//  SearchFM
//
//  Created by mymac on 29/08/20.
//

import UIKit
import Foundation

typealias CompletionHandler = (_ success: Bool, _ response: Any?) -> Void

class NetworkHttpClient: NSObject {
    
    struct Constants {
        static let apiKey = "c68711f5757c83e1eb76b48aab9d3780"
        static let baseUrl: String = "http://ws.audioscrobbler.com/2.0/?api_key=\(apiKey)&format=json"
        static let albumSearchURL: String = baseUrl + "&method=album.search&album="
        static let artistSearchURL: String = baseUrl + "&method=artist.search&artist="
        static let trackSearchURL: String = baseUrl + "&method=track.search&track="
        
        enum SearchURL {
            case album
            case artist
            case track
            
            func url(for search: String) -> String {
                switch self {
                case .album:
                    return albumSearchURL + search
                case .artist:
                    return artistSearchURL + search
                case .track:
                    return trackSearchURL + search
                }
            }
        }
    }
    
    static let contactsURL:String = "/contacts.json"
    static let contactsDetailsURL:String = "/contacts/%d.json"
    static let getMethod:String = "GET"
    static let postMethod:String = "POST"
    static let putMethod:String = "PUT"
    static let deleteMethod:String = "DELETE"
    
    typealias successBlock = (_ response: Data) -> Void
    typealias failureBlock = (_ response: Error?) -> Void
    
    static let sharedInstance = NetworkHttpClient()
    
}

extension NetworkHttpClient {
    
    func performAPICall(_ strURL : String?, method: String? = getMethod, parameters : Dictionary<String, Any>?, success:@escaping successBlock, failure:@escaping failureBlock){
        if let urlPath:String = strURL {
            
            guard let url = URL(string: "http://gojek-contacts-app.herokuapp.com" + urlPath) else { return }
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
