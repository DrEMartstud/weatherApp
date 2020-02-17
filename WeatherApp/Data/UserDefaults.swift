//
//  UserDefaults.swift
//  WeatherApp
//
//  Created by DrEMartstud on 16.02.2020.
//  Copyright © 2020 DrEMartstud. All rights reserved.
//

import Foundation

class CityInfo {
    enum key: String {
        case cityName
        case weather_code
        case weather_descriptions
        case temperature
        case humidity
        case wind_speed
        case pressure
    }
    static var cityName: String {
        get {return UserDefaults.standard.string(forKey: key.cityName.rawValue) ?? ""}
        set {UserDefaults.standard.set(newValue, forKey: key.cityName.rawValue)}
    }
    static var weather_code: Int {
        get {return UserDefaults.standard.integer(forKey: key.weather_code.rawValue)}
    set {UserDefaults.standard.set(newValue, forKey: key.weather_code.rawValue)}
    }
    static var weather_descriptions: String {
        get {return UserDefaults.standard.string(forKey: key.weather_descriptions.rawValue) ?? ""}
    set {UserDefaults.standard.set(newValue, forKey: key.weather_descriptions.rawValue)}
    }
    static var temperature: Double{
        get {return UserDefaults.standard.double(forKey: key.temperature.rawValue)}
    set {UserDefaults.standard.set(newValue, forKey: key.temperature.rawValue)}
    }
    static var humidity: Double{
        get {return UserDefaults.standard.double(forKey: key.humidity.rawValue)}
    set {UserDefaults.standard.set(newValue, forKey: key.humidity.rawValue)}
    }
    static var wind_speed: Double {
        get {return UserDefaults.standard.double(forKey: key.wind_speed.rawValue)}
    set {UserDefaults.standard.set(newValue, forKey: key.wind_speed.rawValue)}
    }
    static var pressure: Double {
        get {return UserDefaults.standard.double(forKey: key.pressure.rawValue)}
    set {UserDefaults.standard.set(newValue, forKey: key.pressure.rawValue)}
    }
}
