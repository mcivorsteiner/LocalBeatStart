//
//  SearchResultsController.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/4/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import UIKit

class SearchResultsController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(SearchResultsController.dismissSearchResultsController))
        
        tableView.tableHeaderView = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = false
        searchController.searchResultsUpdater = self
//        searchController.delegate = self
    }

    func dismissSearchResultsController() {
        self.dismiss(animated: true, completion: nil)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }
}

extension SearchResultsController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        print(searchController.searchBar.text!)
        
    }
}

//extension SearchResultsController: UISearchControllerDelegate {
//    func didPresentSearchController(_ searchController: UISearchController) {
//        searchController.isActive = true
//        searchController.searchBar.becomeFirstResponder()
//    }
//}
