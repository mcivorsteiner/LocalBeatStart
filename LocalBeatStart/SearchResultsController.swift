//
//  SearchResultsController.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/4/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import UIKit

protocol SearchResultsControllerDelegate: class {
    func didSelectLocation(_ location: SKLocationResult)
}

class SearchResultsController: UITableViewController {
    
    weak var delegate: SearchResultsControllerDelegate?
    
    let searchController = UISearchController(searchResultsController: nil)
    let dataSource = LocationResultsDataSource()
    let SKClient = SKApiClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SearchResultsController.dismissSearchResultsController))
        
        tableView.tableHeaderView = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
        
        tableView.dataSource = dataSource
//        searchController.delegate = self
    }

    func dismissSearchResultsController() {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.didSelectLocation(dataSource.location(at: indexPath))
        self.dismiss(animated: true, completion: nil)
    }
}

extension SearchResultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if searchController.searchBar.text!.characters.count <= 2 { return }
        
        SKClient.locationSearch(query: searchController.searchBar.text!) { [weak self] responseObject, error in
            if let responseObject = responseObject {
                let locations = responseObject.resultsPage.results.locations
                self?.dataSource.update(with: locations)
                self?.tableView.reloadData()
            } else {
                print("ERROR" + String(describing: error))
                self?.showAlert(title: "Error", message: String(describing: error))
            }
        }
        print(searchController.searchBar.text!)
        
    }
    
    func showAlert(title: String, message: String, preferredStyle: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
}

//extension SearchResultsController: UISearchControllerDelegate {
//    func didPresentSearchController(_ searchController: UISearchController) {
//        searchController.isActive = true
//        searchController.searchBar.becomeFirstResponder()
//    }
//}
