//
//  DetailsViewController.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//

import UIKit
import SDWebImage
import WebKit

protocol DetailsDisplayLogic: class
{
    func display(record: Record)
}

class DetailsViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var webView: WKWebView!
    
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
        let presenter = DetailsPresenter()
        interactor.presenter = presenter
        presenter.viewController = viewController
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
        
        interactor?.display(record: record)
    }
    
}

extension DetailsViewController: DetailsDisplayLogic {
    
    func display(record: Record) {
        DispatchQueue.main.async {
            self.nameLabel.text = record.name
            if let url: URL = record.displayImageURL {
                self.imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "placeholderImage"))
            }
            
            if let urlPath = record.url, let url: URL = URL(string: urlPath) {
                self.webView.load(URLRequest(url: url))
            }
        }
    }
}
