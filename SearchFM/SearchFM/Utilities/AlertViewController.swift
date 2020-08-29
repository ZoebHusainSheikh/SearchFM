//
//  AlertViewController.swift
//  SearchFM
//
//  Created by mymac on 29/08/20.
//

import Foundation
import UIKit

class AlertViewController {
    
    static let sharedInstance = AlertViewController()
    static let kSomethingWentWrongMessage = "Something went wrong"
    
    //This is alert function
    func alertWindow(title: String = "Error", message: String = AlertViewController.kSomethingWentWrongMessage) {
        DispatchQueue.main.async {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
            let defaultAction = UIAlertAction(title: "OK", style: .default, handler: { action in
            })
            alertController.addAction(defaultAction)
            let alertWindow = UIApplication.shared.windows.first
            alertWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
        }
    }
}
