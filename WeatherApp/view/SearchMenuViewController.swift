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
    var cityNameForRequest: String?
    var previousCityNameForRequest: String?
//MARK:- ViewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        searchBar.delegate = self
        checkLocationServices()
        beautifyView()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tapGesture)
    }
////MARK:- Transition to next view
//    func transitionToViewController() {
//        let newVC = storyboard?.instantiateViewController(withIdentifier: "WeatherViewController") as! WeatherViewController
//               navigationController?.pushViewController(newVC, animated: true)
//    }
//MARK:- Setup Location manager
    func setupLocationManager() {
        mapView.delegate = self
        locationManager.delegate = self //запускается делегат в extension
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
   
//MARK:- Open and close SearchView
    func openSearchView() {
        guard searchView.isHidden else { return }
        searchView.isHidden = false
    }
    func closeSearchView() {
        guard searchView.isHidden == false else { return }
        searchView.isHidden = true
    }
//MARK:- Center View On Locaion
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
    
//MARK:- Close view
    @IBAction func xCloseView(_ sender: UIButton) {
        closeSearchView()
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
//        centerViewOnUserLocation()
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
//MARK:- Request weather
    func requestWeather(forCity: String) {
        guard forCity != previousCityNameForRequest else { return }
        previousCityNameForRequest = forCity
        let key = "f4919842e423082102ed69df019dca83"
        let urlString = "http://api.weatherstack.com/current?access_key=\(key)&query=\(forCity)"
        guard let url = URL(string: urlString) else { return }
        
        var locationName: String?
        var temperature: Double?
        var weather_code: Int?
        var weather_descriptions: String?
        var humidity: Double?
        var wind_speed: Double?
        var pressure: Double?
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            do {
                let json = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! [String : AnyObject]
                
                if let location = json["location"] {
                    locationName = location["name"] as? String
                    CityInfo.cityName = locationName!
                }
                if let current = json["current"] {
                    temperature = current["temperature"] as? Double
                    weather_code = current["weather_code"] as? Int
                    wind_speed = current["wind_speed"] as? Double
                    humidity = current["humidity"] as? Double
                    wind_speed = current["wind_speed"] as? Double
                    pressure = current["pressure"] as? Double
                    CityInfo.temperature = temperature ?? 0.0
                    CityInfo.weather_code = weather_code ?? 0
                    CityInfo.humidity = humidity ?? 0.0
                    CityInfo.wind_speed = wind_speed ?? 0.0
                    CityInfo.pressure = pressure ?? 0.0
                }
            }
            catch let jsonError {
                print(jsonError)
            }
        }
        task.resume()
        
    }

////MARK:- Request Weather button
//
//    @IBAction func WeatherRequest(_ sender: Any) {
//        transitionToViewController()
//    }
//MARK:- Show weather view button
    @IBAction func ShowWeatherViewButton(_ sender: Any) {
        requestWeather(forCity: cityNameForRequest ?? "")
        openSearchView()
    }
    //MARK:- closeKeyboard
    @objc func closeKeyboard() {
    view.endEditing(true)
    }
}
///
///
///
//MARK:- Extensions
///
///
///
//MARK:- Searchbar delegate
extension SearchMenuViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
    }
}

//MARK:- CLLocationManagerDelegate
extension SearchMenuViewController: CLLocationManagerDelegate {
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        let region = MKCoordinateRegion.init(center: location.coordinate, latitudinalMeters: regionInMeters, longitudinalMeters: regionInMeters)
//
//    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        checkLocationAuthorization()
    }
}
//MARK:- mapView moved
extension SearchMenuViewController: MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        let center = getCenterLocation(for: mapView)
        let geoCoder = CLGeocoder()
    
        guard let previousLocation = self.previousLocation else { return }
        guard center.distance(from: previousLocation) > 50 else { return }
       
        self.previousLocation = center
        closeSearchView()
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
            let cityName = placemark.locality ?? ""
            CityInfo.cityName = cityName
            let latitude = placemark.location!.coordinate.latitude
            let longitude = placemark.location!.coordinate.longitude
            self.cityNameForRequest = cityName
            DispatchQueue.main.async {
                self.titleLabel.text = "\(cityName)"
                self.descriptionLabel.text = "\(String(latitude)) \(String(longitude))"
            }
        }
    }
}
	




//let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
