//
//  SKIdentifier.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/4/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import Foundation
import Mapper

struct SKIdentifier: Mappable {
    let href: String
    let mbid: String
    
    init(map: Mapper) throws {
        try href = map.from("href")
        try mbid = map.from("mbid")
    }
}
