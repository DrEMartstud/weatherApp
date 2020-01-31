//
//  UIlabel+style.swift
//  WeatherApp
//
//  Created by Андрей Головченко on 26.12.2019.
//  Copyright © 2019 DrEMartstud. All rights reserved.
//

import UIKit

extension UILabel {
    func set(_ style: FontStyleData) {
        self.font = style.font
        self.textColor = style.color
    }
}
