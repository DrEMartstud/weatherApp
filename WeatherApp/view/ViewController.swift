//
//  ViewController.swift
//  WeatherApp
//
//  Created by Андрей Головченко on 14.12.2019.
//  Copyright © 2019 DrEMartstud. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
//MARK:- Outlets
    @IBOutlet weak var backgroundImage: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var weatherStateIcon: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var weatherStateLabel: UILabel!
    @IBOutlet weak var humidityPercentageLabel: UILabel!
    @IBOutlet weak var windMSLabel: UILabel!
    @IBOutlet weak var pressureMMHGLabel: UILabel!
    
//    @IBOutlet private var secondaryLabel: [UILabel]!
//    @IBOutlet private  var mainLabel: [UILabel]! 
    
    
    
    
//    let apiKey = "35f73bd26a806e34af48af53aeaedeff"
//    let cityName = "Kaliningrad"
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
        let weatherState = WeatherState.night
        let weatherImage = BackGroundImage.night
        weatherStateIcon.image = weatherState
        backgroundImage.image = weatherImage
        cityNameLabel.text = CityInfo.cityName
    }
//     "35f73bd26a806e34af48af53aeaedeff Kaliningrad"
//    //let urlString = "http://api.weatherstack.com/current?access_key=\(apiKey)&query=\(cityName)"

//          let session = URLSession.shared
//    session.dataTask(with: url) { (data, response, error) in
//    if let response = response {
//        print(response)
//        }
//    guard let data = data else {return}
//    print(data)
//
//    do {
//    let json = try JSONSerialization.jsonObject(with: data, options: [])
//
//    }
//    }
//
//    session.resume()

}
