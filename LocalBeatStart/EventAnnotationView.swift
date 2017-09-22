//
//  EventAnnotationView.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 9/18/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import UIKit
import MapKit

private let kPersonMapPinImage = #imageLiteral(resourceName: "redMapPin")
private let kEventMapAnimationTime = 0.300

class EventAnnotationView: MKAnnotationView {
    weak var eventDetailDelegate: EventDetailMapViewDelegate?
    weak var customCalloutView: EventDetailMapView?
//    weak var customCalloutView: UIView?
    
    override var annotation: MKAnnotation? {
        willSet { customCalloutView?.removeFromSuperview() }
    }
    
    // MARK: - life cycle
    
    override init(annotation: MKAnnotation?, reuseIdentifier: String?) {
        super.init(annotation: annotation, reuseIdentifier: reuseIdentifier)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.canShowCallout = false
        self.image = kPersonMapPinImage
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            self.customCalloutView?.removeFromSuperview()
            
            if let newCustomCalloutView = loadEventDetailMapView() {
                newCustomCalloutView.frame.origin.x -= newCustomCalloutView.frame.width / 2.0 - (self.frame.width / 2.0)
                newCustomCalloutView.frame.origin.y -= newCustomCalloutView.frame.height
                
                self.addSubview(newCustomCalloutView)
                self.customCalloutView = newCustomCalloutView
                
                if animated {
                    self.customCalloutView!.alpha = 0.0
                    UIView.animate(withDuration: kEventMapAnimationTime, animations: {
                        self.customCalloutView!.alpha = 1.0
                    })
                }
            }
        } else {
            if customCalloutView != nil {
                if animated {
                    UIView.animate(withDuration: kEventMapAnimationTime, animations: {
                        self.customCalloutView!.alpha = 0.0
                    }, completion: { (success) in
                        self.customCalloutView!.removeFromSuperview()
                    })
                } else { self.customCalloutView!.removeFromSuperview() }
            }
        }
    }
    
    func loadEventDetailMapView() -> EventDetailMapView? {
        if let views = Bundle.main.loadNibNamed("EventDetailMapView", owner: self, options: nil) as? [EventDetailMapView], views.count > 0 {
            let eventDetailMapView = views.first!
            eventDetailMapView.delegate = self.eventDetailDelegate
            
            if let eventAnnotation = annotation as? EventAnnotation {
                eventDetailMapView.configureWithAnnotation(eventAnnotation)
            }
            
            return eventDetailMapView
        }
        
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.customCalloutView?.removeFromSuperview()
    }
    
    // MARK: - Detecting and reaction to taps on custom callout.
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        // if super passed hit test, return the result
        if let parentHitView = super.hitTest(point, with: event) { return parentHitView }
        else { // test in our custom callout.
            if customCalloutView != nil {
                return customCalloutView!.hitTest(convert(point, to: customCalloutView!), with: event)
            } else { return nil }
        }
    }
}
