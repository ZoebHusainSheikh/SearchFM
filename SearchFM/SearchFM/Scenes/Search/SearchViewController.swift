//
//  SearchViewController.swift
//  SearchFM
//
//  Created by Zoeb Husain Sheikh on 29/08/20.
//

import UIKit

protocol SearchDisplayLogic: class
{
    func display(viewModel: Search.Fetch.ViewModel)
    func stopAnimation()
}

class SearchViewController: UIViewController {
    
    @IBOutlet weak var segmentControl: UISegmentedControl!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    var interactor: SearchBusinessLogic?
    var router: (NSObjectProtocol & SearchRoutingLogic & SearchDataPassing)?
    var records: [Record]?
    
    
    struct SearchConstants {
        static let rowHeight: CGFloat = 70.0
        static let cellReuseIdentifier: String = SearchTableViewCell.className
    }
    
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
        let interactor = SearchInteractor()
        let presenter = SearchPresenter()
        let router = SearchRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: View lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableView.automaticDimension
    }
}

private extension SearchViewController {
    
    // MARK: - Actions
    @IBAction func tabSelected(_ sender: UISegmentedControl) {
        performSearchAction()
    }
}

private extension SearchViewController {
    
    var searchTab: SearchType {
        let selectedTabIndex = segmentControl.selectedSegmentIndex
        return SearchType(rawValue: selectedTabIndex) ?? .artist
    }
    
    func performSearchAction() {
        performSearchAPI(with: searchTab)
    }
    
    // MARK: Search API
    
    func performSearchAPI(with type: SearchType) {
        guard let searchText = searchBar.text?.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed), !searchText.isEmpty else { return }
        
        showProgressHUD()
        let url: String = type.url(for: searchText)
        let request = Search.Fetch.Request(url: url)
        interactor?.fetch(request: request)
    }
}

extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        performSearchAction()
    }
}

extension SearchViewController: SearchDisplayLogic {
    
    func display(viewModel: Search.Fetch.ViewModel) {
        switch searchTab {
        case .artist:
            self.records = viewModel.results?.artistMatches?.artists
        case .album:
            self.records = viewModel.results?.albumMatches?.albums
        case .track:
            self.records = viewModel.results?.trackMatches?.tracks
        }
        
        
        DispatchQueue.main.async {
            self.tableView.isHidden = false
            self.tableView.reloadData()
            self.view.endEditing(true)
        }
    }
    
    func stopAnimation() {
        dismissProgressHUD()
    }
}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.records?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let records = self.records, records.count > indexPath.row else {
            return UITableViewCell()
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchConstants.cellReuseIdentifier, for: indexPath) as! SearchTableViewCell
        cell.setup(by: records[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        guard let records = self.records, records.count > indexPath.row else { return }
        
        interactor?.record = records[indexPath.row]
        router?.routeToDetails()
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return SearchConstants.rowHeight
    }
}
