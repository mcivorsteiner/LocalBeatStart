//
//  SKArtist.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/4/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import Foundation
import Mapper

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
