//
//  EventDetailMapView.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/18/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import UIKit

protocol EventDetailMapViewDelegate: class {
    func detailsRequestedForEvent(annotation: EventAnnotation)
}

class EventDetailMapView: UIView {
    var annotation: EventAnnotation!
    weak var delegate: EventDetailMapViewDelegate?
    
    @IBOutlet weak var backgroundContentButton: UIButton!
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var venueNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var seeDetailsButton: UIButton!
    
    @IBAction func seeDetailsClick(_ sender: Any) {
        delegate?.detailsRequestedForEvent(annotation: annotation)
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureWithAnnotation(_ annotation: EventAnnotation) {
        self.annotation = annotation
        
        artistNameLabel.text = annotation.artistName ?? annotation.eventName
        venueNameLabel.text = annotation.venueName
        eventDateLabel.text = annotation.displayDate
//        backgroundContentButton.applyArrowDialogAppearanceWithOrientation(arrowOrientation: .down)
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // Check if it hit our annotation detail view components.
        
        // details button
        return seeDetailsButton.hitTest(convert(point, to: seeDetailsButton), with: event)

        // fallback to our background content view
//        return backgroundContentButton.hitTest(convert(point, to: backgroundContentButton), with: event)
    }
}
