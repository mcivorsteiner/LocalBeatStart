//
//  LocationResultsDataSource.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/4/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import UIKit

class LocationResultsDataSource: NSObject, UITableViewDataSource {
    
    private var data = [SKLocationResult]()
    
    override init() {
        super.init()
    }
    
    func update(with locations: [SKLocationResult]) {
        data = locations
    }
    
    // MARK: - Data Source
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ResultCell", for: indexPath)
        
        let location = data[indexPath.row]
        cell.textLabel?.text = location.city.displayNameFull
        
        return cell
    }
    
    // MARK: - Helper
    
    func location(at indexPath: IndexPath) -> SKLocationResult {
        return data[indexPath.row]
    }
    
}
