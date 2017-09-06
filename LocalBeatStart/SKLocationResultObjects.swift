//
//  SKLocationResult.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/4/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import Foundation
import Mapper
import CoreLocation

struct SKCityResult: Mappable {
    let displayName: String
    let lat: Double?
    let lng: Double?
    let country: String
    let state: String?
    var displayNameFull: String {
        if let state = state {
            return "\(displayName), \(state), \(country)"
        } else {
            return "\(displayName), \(country)"
        }
    }
    
    var coordinate: CLLocationCoordinate2D? {
        guard let latitude = lat, let longitude = lng else { return nil }
        
        return CLLocationCoordinate2DMake(latitude, longitude)
    }
    
    init(map: Mapper) throws {
        try displayName = map.from("displayName")
        lat = map.optionalFrom("lat")
        lng = map.optionalFrom("lng")
        try country = map.from("country.displayName")
        state = map.optionalFrom("state.displayName")
    }
}

struct SKLocationResult: Mappable {
    let city: SKCityResult
    let metroArea: SKMetroArea
    
    init(map: Mapper) throws {
        try city = map.from("city")
        try metroArea = map.from("metroArea")
    }
}
