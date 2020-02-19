//
//  ViewController.swift
//  WeatherApp
//
//  Created by Андрей Головченко on 14.12.2019.
//  Copyright © 2019 DrEMartstud. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController {
//MARK:- Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherStateIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    @IBOutlet weak var humidityPercentageLabel: UILabel!
    @IBOutlet weak var windMSLabel: UILabel!
    @IBOutlet weak var pressureMMHGLabel: UILabel!
//MARK:- viewDidLoad()
    override func viewDidLoad() {
        super.viewDidLoad()
        updateView()
    }
    override func viewWillAppear(_ animated: Bool) {
       
    }
//MARK:- Update View
    func updateView() {
        DispatchQueue.main.async {
            self.roundefyImage()
            self.setWeatherInfo()
        }
    }
//MARK:- Roundefy Image
    func roundefyImage() {
        let path = UIBezierPath(ovalIn: CGRect(x: backgroundImage.bounds.width * 0.4, y: 0, width: backgroundImage.bounds.height, height: backgroundImage.bounds.height)).cgPath
               let overlay = CAShapeLayer()
               overlay.path = path
               overlay.fillColor = UIColor.white.cgColor
               overlay.shouldRasterize = true
               backgroundImage.layer.mask = overlay
    }
//MARK:- Set weather info
    func setWeatherInfo(){
        cityNameLabel.text = CityInfo.cityName
        weatherStateLabel.text = "\(CityInfo.weather_descriptions)"
        switch CityInfo.weather_code {
        case 113:
            weatherStateIcon.image = WeatherState.clearSun
            backgroundImage.image = BackGroundImage.clearSun
            weatherStateLabel.text = "Clear Sky"
        case 176...200:
            weatherStateIcon.image = WeatherState.rain
            backgroundImage.image = BackGroundImage.rain
            weatherStateLabel.text = "Rain"
        case 248...311:
            weatherStateIcon.image = WeatherState.rain
            backgroundImage.image = BackGroundImage.rain
            weatherStateLabel.text = "Rain"
        case 227...230:
            weatherStateIcon.image = WeatherState.snow
            backgroundImage.image = BackGroundImage.snow
            weatherStateLabel.text = "Snow"
        case 116...143:
            weatherStateIcon.image = WeatherState.sunAndCloud
            backgroundImage.image = BackGroundImage.sunAndCloud
            weatherStateLabel.text = "Partly Cloudy"
        default:
            print("Default value of weather state got triggered")
        }
        temperatureLabel.text = "\(CityInfo.temperature)"
        humidityPercentageLabel.text = "\(CityInfo.humidity)%"
        windMSLabel.text = "\(CityInfo.wind_speed) m/s"
        pressureMMHGLabel.text = "\(CityInfo.pressure) mm Hg"
    }
}
