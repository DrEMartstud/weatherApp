//
//  SearchMenuViewController.swift
//  WeatherApp
//
//  Created by DrEMartstud on 31.01.2020.
//  Copyright © 2020 DrEMartstud. All rights reserved.
//

import UIKit
import MapKit
class SearchMenuViewController: UIViewController {
//MARK:- Outlets
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var showWeatherViewButton: UIView!
//MARK:- lets
    let locationManager = CLLocationManager()
    let regionInMeters:Double = 10000
//MARK:- ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        checkLocationServices()
        beautifyView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tapGesture)
        
    }
    
    
//MARK:- Setup Location manager
    func setupLocationManager() {
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
//MARK:- centerViewOnUserLocation()
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
            print("Region is:  \(region)")
        }
    }
//MARK:- Check Location Services
    func checkLocationServices() {
        if CLLocationManager.locationServicesEnabled() {
            setupLocationManager()
            checkLocationAuthorization()
        } else {
            //Alert
        }
    }
    
//MARK:- checkLocationAuthorization()
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            mapView.showsUserLocation = true
            centerViewOnUserLocation()
            locationManager.startUpdatingLocation()
            break
        case .denied:
            //show alert: turn on permisions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
            break
        case .restricted:
            //show alert to let know
            break
        case .authorizedAlways:
           
            break
        @unknown default:
            
            break
        }
    }
    //MARK:- beautifyView
    func beautifyView() {
        searchView.layer.cornerRadius = 4
        searchView.layer.shadowOffset = CGSize(width: 0, height: 0)
        searchView.layer.shadowColor = UIColor.black.cgColor
        searchView.layer.shadowRadius = 12
        searchView.layer.shadowOpacity = 0.3
        showWeatherViewButton.layer.cornerRadius = 27
        showWeatherViewButton.layer.borderColor = UIColor.systemBlue.cgColor
        showWeatherViewButton.layer.borderWidth = 1
    }
//MARK:- closeKeyboard()
    @objc func closeKeyboard() {
    view.endEditing(true)
    }
}
//MARK:- extension SearchMenuViewController
extension SearchMenuViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion.init(center: center, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
        mapView.setRegion(region, animated: true)
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
    }
}
