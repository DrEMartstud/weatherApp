//
//  SearchMenuViewController.swift
//  WeatherApp
//
//  Created by DrEMartstud on 31.01.2020.
//  Copyright © 2020 DrEMartstud. All rights reserved.
//

import UIKit

class SearchMenuViewController: UIViewController {
    
    @IBOutlet weak var searchView: SearchView!
    @IBOutlet weak var showWeatherViewButton: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(closeKeyboard))
        view.addGestureRecognizer(tapGesture)
        searchView.layer.cornerRadius = 4
        searchView.layer.shadowOffset = CGSize(width: 0, height: 0)
        searchView.layer.shadowColor = UIColor.black.cgColor
        searchView.layer.shadowRadius = 12
        searchView.layer.shadowOpacity = 0.3
        showWeatherViewButton.layer.cornerRadius = 27
        showWeatherViewButton.layer.borderColor = UIColor.systemBlue.cgColor
        showWeatherViewButton.layer.borderWidth = 1
        
    }
    @objc func closeKeyboard() {
    view.endEditing(true)
}

}

