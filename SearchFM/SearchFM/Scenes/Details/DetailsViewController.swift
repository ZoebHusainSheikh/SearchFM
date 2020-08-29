//
//  DetailsViewController.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//

import UIKit
import SDWebImage
import WebKit

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
    var record: Record?
    var interactor: DetailsBusinessLogic?

    // MARK: Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    // MARK: Setup
    
    private func setup()
    {
        let viewController = self
        let interactor = DetailsInteractor()
        viewController.interactor = interactor
    }
    
    // MARK: View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseView()
    }

}

private extension DetailsViewController {
    
    func initialiseView() {
        guard let record = interactor?.record else { return }
        
        nameLabel.text = record.name
        if let url: URL = record.displayImageURL {
            imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholderImage"))
        }
        
        if let urlPath = record.url, let url: URL = URL(string: urlPath) {
            webView.load(URLRequest(url: url))
        }
    }
    
}
