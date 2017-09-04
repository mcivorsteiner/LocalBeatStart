//
//  SKPerformance.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/4/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import Foundation
import Mapper

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
