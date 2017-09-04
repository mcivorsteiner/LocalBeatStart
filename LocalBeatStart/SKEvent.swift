//
//  SKEvent.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/4/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import Foundation
import Mapper

class SKEvent: NSObject, Mappable {
    
    struct SKStart: Mappable {
        let date: String
        let time: String?
        let datetime: String?
        
        init(map: Mapper) throws {
            try date = map.from("date")
            time = map.optionalFrom("time")
            datetime = map.optionalFrom("datetime")
        }
    }
    
    let id: Int
    let displayName: String
    let type: String
    let popularity: Float
    let uri: String
    let venue: SKVenue
    let location: SKLocation
    let start: SKStart
    let performance: [SKPerformance]
    let ageRestriction: String?
    var headliner: SKPerformance? {
        let headliners = performance.filter { $0.billingIndex == 1 }
        return headliners.first
    }
    
    required init(map: Mapper) throws {
        try id = map.from("id")
        try displayName = map.from("displayName")
        try type = map.from("type")
        try popularity = map.from("popularity")
        try uri = map.from("uri")
        try venue = map.from("venue")
        try location = map.from("location")
        try start = map.from("start")
        try performance = map.from("performance")
        ageRestriction = map.optionalFrom("ageRestriction")
    }
}

import MapKit

extension SKEvent: MKAnnotation {
    var coordinate: CLLocationCoordinate2D {
        return CLLocationCoordinate2D(latitude: CLLocationDegrees(location.lat), longitude: CLLocationDegrees(location.lng))
    }
    var title: String? {
        if let headlinerDisplayName = headliner?.artist.displayName {
            return headlinerDisplayName
        } else {
            return displayName
        }
    }
    
    var subtitle: String? {
        return venue.displayName
    }
}
