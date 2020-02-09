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
    @IBOutlet weak var debugLabel: UILabel!
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var showWeatherViewButton: UIView!
    @IBOutlet var titleLabel: UILabel! {
         didSet {
            titleLabel.set(Font.h1)
         }
     }
    @IBOutlet var descriptionLabel: UILabel! {
        didSet {
            descriptionLabel.set(Font.body)
        }
    }
//MARK:- lets and vars
    let locationManager = CLLocationManager()
    let regionInMeters:Double = 10000
    var previousLocation: CLLocation?
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
        locationManager.delegate = self //запускается делегат в extension
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
//MARK:- centerViewOnUserLocation
    func centerViewOnUserLocation() {
        if let location = locationManager.location?.coordinate {
            let region = MKCoordinateRegion.init(center: location, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
            mapView.setRegion(region, animated: true)
        }
    }
    @IBAction func centerMapButon(_ sender: UIButton) {
        centerViewOnUserLocation()
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
    
//MARK:- checkLocationAuthorization
    func checkLocationAuthorization() {
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse:
            startTrackingUserLocation()
        case .denied:
            //show alert: turn on permisions
            break
        case .notDetermined:
            locationManager.requestWhenInUseAuthorization()
        case .restricted:
            //show alert to let know
            break
        case .authorizedAlways:
            break
        @unknown default:
            break
        }
    }
    func startTrackingUserLocation() {
        mapView.showsUserLocation = true
        centerViewOnUserLocation()
        locationManager.startUpdatingLocation()
        previousLocation = getCenterLocation(for: mapView)
        //print("PrevLoc: \(previousLocation)")
    }
    
    //MARK:- getCenterLocation
    func getCenterLocation(for mapView: MKMapView) -> CLLocation {
        let latitude = mapView.centerCoordinate.latitude
        let longitude = mapView.centerCoordinate.longitude
        return CLLocation(latitude: latitude, longitude: longitude)
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
//MARK:- closeKeyboard
    @objc func closeKeyboard() {
    view.endEditing(true)
    }
}
//MARK:- Extensions
extension SearchMenuViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//        mapView.setRegion(region, animated: true)
//    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}

extension SearchMenuViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
    
        guard let previousLocation = self.previousLocation else { return }
        guard center.distance(from: previousLocation) > 50 else { return }
       
        self.previousLocation = center
        
        geoCoder.reverseGeocodeLocation(center) { [weak self] (placemarks, error) in
            guard let self = self else { return }
            if let _ = error {
                //TODO: alert
                return
            }
            guard let placemark = placemarks?.first else {
                //TODO: alert
                return
            }
            
           // let streetName = placemark.subThoroughfare ?? " "
            let cityName = placemark.locality ?? "cityName"
            let coordinates = placemark.location ?? nil
            DispatchQueue.main.async {
                self.titleLabel.text = "\(cityName)"
                self.descriptionLabel.text = "\(coordinates)"
            }
        }
    }
}





//let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
