//
//  SKMetroArea.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/4/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import Foundation
import Mapper

struct SKMetroArea: Mappable {
    let id: Int
    let displayName: String
    let uri: String
    let country: String
    let state: String?
    let lat: Double?
    let lng: Double?
    
    init(map: Mapper) throws {
        try id = map.from("id")
        try displayName = map.from("displayName")
        try uri = map.from("uri")
        try country = map.from("country.displayName")
        state = map.optionalFrom("state.displayName")
        lat = map.optionalFrom("lat")
        lng = map.optionalFrom("lng")
    }
}
