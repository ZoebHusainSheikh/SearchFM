//
//  DetailsViewController.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//

import UIKit

protocol DetailsDisplayLogic: class
{
    func displayDetails(viewModel: Details.Fetch.ViewModel)
    func stopAnimation()
    func refreshDetails()
}

class DetailsViewController: UIViewController {
    
    var router: (NSObjectProtocol & DetailsRoutingLogic & DetailsDataPassing)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
