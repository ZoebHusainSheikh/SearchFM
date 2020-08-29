//
//  Common+Extension.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//

import Foundation
import UIKit
import MBProgressHUD

extension UIViewController {
    
    func showProgressHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.showAdded(to: self.view, animated: true)
        }
    }
    
    func dismissProgressHUD() {
        DispatchQueue.main.async {
            MBProgressHUD.hide(for: self.view, animated: true)
        }
    }
    
    static var className: String {
        return "\(self)"
    }
}

extension UIView {
    
    static var className: String {
        return "\(self)"
    }
}
