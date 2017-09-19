//
//  EventAnnotation.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/18/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class EventAnnotation: NSObject, MKAnnotation {
    let coordinate: CLLocationCoordinate2D
    let eventName: String
    var artistName: String?
    let venueName: String
    let displayDate: String
    var displayTime: String?
    
    init(skEvent: SKEvent) {
        self.coordinate = skEvent.coordinate
        self.eventName = skEvent.displayName
        self.artistName = skEvent.headliner?.artist.displayName
        self.venueName = skEvent.venue.displayName
        self.displayDate = skEvent.start.date
        self.displayTime = skEvent.start.time
        super.init()
    }
    
    var title: String? {
        return artistName ?? eventName
    }
    
    var subtitle: String? {
        return venueName
    }
}
