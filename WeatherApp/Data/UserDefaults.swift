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
        case coords
    }
    static var cityName: String {
        get {return UserDefaults.standard.string(forKey: key.cityName.rawValue) ?? ""}
        set {UserDefaults.standard.set(newValue, forKey: key.cityName.rawValue)}
    }
}
