//
//  SKLocation.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/4/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import Foundation
import Mapper

struct SKCountry: Mappable {
    let displayName: String
    
    init(map: Mapper) throws {
        try displayName = map.from("displayName")
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
