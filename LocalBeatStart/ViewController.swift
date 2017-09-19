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

private let kEventAnnotationName = "concertDetailAnnotationName"

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, SearchResultsControllerDelegate {
    
    //MARK: Outlets
    @IBOutlet weak var map: MKMapView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var searchIcon: UIImageView!
    
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
        map.delegate = self
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SearchSegue" {
            guard let navigationController = segue.destination as? UINavigationController, let searchController = navigationController.topViewController as? SearchResultsController else { return }
            
            searchController.delegate = self
        }
    }
    
    func didSelectLocation(_ location: SKLocationResult) {
        fetchConcertsFrom(lat: location.city.coordinate!.latitude, lng: location.city.coordinate!.longitude)
        setMapCenter(latitude: location.city.coordinate!.latitude, longitude: location.city.coordinate!.longitude)
    }
    
    //MARK: Location Manager Delagate
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLocation = location
            fetchConcertsFrom(lat: location.coordinate.latitude, lng: location.coordinate.longitude)
            
            setMapCenter(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        
            self.map.showsUserLocation = true
        }
    }
    
    func setMapCenter(latitude: Double, longitude: Double) {
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.3, 0.3)
        let mapCenterCoordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(latitude, longitude)
        let region: MKCoordinateRegion = MKCoordinateRegionMake(mapCenterCoordinate, span)
        map.setRegion(region, animated: true)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locManager.requestLocation()
        }
    }
    
    // MARK: - MKMapViewDelegate methods
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        if annotation is MKUserLocation { return nil }
        
        var annotationView = self.map.dequeueReusableAnnotationView(withIdentifier: kEventAnnotationName)
        
        if annotationView == nil {
            annotationView = EventAnnotationView(annotation: annotation, reuseIdentifier: kEventAnnotationName)
        } else {
            annotationView!.annotation = annotation
        }
        
        return annotationView as! EventAnnotationView
    }
    
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView) {
        map.setCenter((view.annotation?.coordinate)!, animated: true)
    }
    
    func showAlert(title: String, message: String, preferredStyle: UIAlertControllerStyle = .alert) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        
        present(alertController, animated: true, completion: nil)
    }
    
    //MARK: Actions
    
    func fetchConcertsFrom(lat: Double, lng: Double) {
        SKClient.eventSearch(lat: lat, lng: lng) { [weak self] responseObject, error in
            if let responseObject = responseObject {
                let events = responseObject.resultsPage.results.events
                let eventAnnotations = events.map { EventAnnotation(skEvent: $0) }
                // should remove existing annotations here
                self?.map.removeAnnotations((self?.map.annotations)!)
                self?.map.addAnnotations(eventAnnotations)
                print("Songkick Call Made Successfully")
            } else {
                self?.showAlert(title: "Error", message: String(describing: error))
            }
        }
    }
}

