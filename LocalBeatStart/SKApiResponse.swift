//
//  SKEventSearchResponse.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 8/26/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import Foundation
import Mapper

struct SKResults: Mappable {
    let events: [SKEvent]
    let locations: [SKLocationResult]
    
    init(map: Mapper) throws {
        do {
            try events = map.from("event")
        } catch MapperError.missingFieldError {
            events = [SKEvent]()
        }
        
        do {
            try locations = map.from("location")
        } catch MapperError.missingFieldError {
            locations = []
        }
    }
    
    
}

struct SKResultsPage: Mappable {
    let page: Int
    let totalEntries: Int
    let perPage: Int
    let results: SKResults
    
    init(map: Mapper) throws {
        try page = map.from("page")
        try totalEntries = map.from("totalEntries")
        try perPage = map.from("perPage")
        try results = map.from("results")
    }
}

struct SKApiResponse: Mappable {
    let resultsPage: SKResultsPage
    
    init(map: Mapper) throws {
        try resultsPage = map.from("resultsPage")
    }
}
