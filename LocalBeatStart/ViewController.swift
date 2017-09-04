//
//  ViewController.swift
//  LocalBeatStart
//
//  Created by Mcivor Steiner on 8/26/17.
//  Copyright © 2017 Mcivor Steiner. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //MARK: Properties
    
    let locManager = CLLocationManager()
    let SKClient = SKApiClient()
    var currentLocation: CLLocation? = nil
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locManager.delegate = self
        locManager.desiredAccuracy = kCLLocationAccuracyBest
        
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                locManager.requestLocation()
            default:
                locManager.requestWhenInUseAuthorization()
            }
        } else {
            locManager.requestWhenInUseAuthorization()
        }
    }
    
    //MARK: Location Manager Delagate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            fetchConcerts()
            let span: MKCoordinateSpan = MKCoordinateSpanMake(0.3, 0.3)
            let myLocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(location.coordinate.latitude, location.coordinate.longitude)
            let region: MKCoordinateRegion = MKCoordinateRegionMake(myLocation, span)
            map.setRegion(region, animated: true)
        
            self.map.showsUserLocation = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locManager.requestLocation()
        }
    }
    
    func showAlert(title: String, message: String, preferredStyle: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Actions
    
    @IBAction func fetchConcerts() {
        if let location = currentLocation {
            SKClient.eventSearch(lat: location.coordinate.latitude, lng: location.coordinate.longitude) { [weak self] responseObject, error in
                if let responseObject = responseObject {
                    let events = responseObject.resultsPage.results.event
                    self?.map.addAnnotations(events)
                    print("Songkick Call Made Successfully")
                } else {
                    self?.showAlert(title: "Error", message: String(describing: error))
                }
            }
        }
    }
}

