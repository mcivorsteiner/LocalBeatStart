//
//  SKEvent.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 8/26/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import Foundation
import Mapper

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

struct SKIdentifier: Mappable {
    let href: String
    let mbid: String
    
    init(map: Mapper) throws {
        try href = map.from("href")
        try mbid = map.from("mbid")
    }
}

struct SKLocation: Mappable {
    let city: String
    let lat: Float
    let lng: Float
    
    init(map: Mapper) throws {
        try city = map.from("city")
        try lat = map.from("lat")
        try lng = map.from("lng")
    }
}

struct SKCountry: Mappable {
    let displayName: String
    
    init(map: Mapper) throws {
        try displayName = map.from("displayName")
    }
}

struct SKMetroArea: Mappable {
    let id: Int
    let displayName: String
    let uri: String
    let country: SKCountry
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try displayName = map.from("displayName")
        try uri = map.from("uri")
        try country = map.from("country")
    }
}

struct SKCity: Mappable {
    let id: Int
    let displayName: String
    let uri: String
    let country: SKCountry
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try displayName = map.from("displayName")
        try uri = map.from("uri")
        try country = map.from("country")
    }
}

struct SKVenue: Mappable {
    let id: Int?
    let displayName: String
    let metroArea: SKMetroArea
    let city: SKCity?
    let zip: String?
    let uri: String?
    let street: String?
    let website: String?
    let capacity: Int?
    let description: String?
    
    init(map: Mapper) throws {
        id = map.optionalFrom("id")
        try displayName = map.from("displayName")
        try metroArea = map.from("metroArea")
        city = map.optionalFrom("city")
        zip = map.optionalFrom("zip")
        uri = map.optionalFrom("uri")
        street = map.optionalFrom("street")
        website = map.optionalFrom("website")
        capacity = map.optionalFrom("capacity")
        description = map.optionalFrom("description")
    }
}

struct SKArtist: Mappable {
    let id: Int
    let displayName: String
    let uri: String
    let identifier: [SKIdentifier]
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try displayName = map.from("displayName")
        try uri = map.from("uri")
        try identifier = map.from("identifier")
    }
}

struct SKPerformance: Mappable {
    let id: Int
    let displayName: String
    let billingIndex: Int
    let billing: String
    let artist: SKArtist
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try displayName = map.from("displayName")
        try billingIndex = map.from("billingIndex")
        try billing = map.from("billing")
        try artist = map.from("artist")
    }
}

class SKEvent: NSObject, Mappable {
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
