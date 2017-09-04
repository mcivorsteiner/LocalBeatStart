//
//  SKVenue.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/4/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import Foundation
import Mapper

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
