//
//  NearByLocationViewController.swift
//  MyHealthApp
//
//  Created by IDEV on 12/08/20.
//  Copyright © 2020 Kavitha Vijayan. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class NearByLocationViewController: UIViewController {
    
    //MARK:- Oulet for map view
    @IBOutlet weak var mapkitView: MKMapView!
    
    var locationManager:CLLocationManager = CLLocationManager()
    
    //MARK:- ViewController LifeCycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.title = "Near by gym".localizableString()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.determineCurrentLocation()
    }
}

//MARK:- CLLocationManagerDelegate Methods and MKMapViewDelegate Methods
extension NearByLocationViewController: CLLocationManagerDelegate,MKMapViewDelegate{
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let mUserLocation:CLLocation = locations[0] as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: mUserLocation.coordinate.latitude, longitude: mUserLocation.coordinate.longitude)
        let mRegion = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        mapkitView.setRegion(mRegion, animated: true)

        mapkitView.showsUserLocation = true
        
        self.nearByFitness()
        
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Error - locationManager: \(error.localizedDescription)")
    }
}

extension NearByLocationViewController {
    //MARK:- Intance Method
    func determineCurrentLocation() {
        mapkitView.delegate = self
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.startUpdatingLocation()
        }
    }
    
    //Mark:- it will find near Gym according key given
    func nearByFitness(){
        let request = MKLocalSearch.Request()
        request.naturalLanguageQuery = "Gym"
        request.region = mapkitView.region
        
        let search = MKLocalSearch(request: request)
        search.start { response, error in
            guard let response = response else {
                print(error ?? "Unknown error")
                return
            }
            
            for mapItem in response.mapItems {
                let mkAnnotation: MKPointAnnotation = MKPointAnnotation()
                mkAnnotation.coordinate = CLLocationCoordinate2DMake(mapItem.placemark.coordinate.latitude, mapItem.placemark.coordinate.longitude)
                mkAnnotation.title =  mapItem.name
                self.mapkitView.addAnnotation(mkAnnotation)
            }
        }
    }
}
