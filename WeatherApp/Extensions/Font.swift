//
//  Font.swift
//  WeatherApp
//
//  Created by Андрей Головченко on 26.12.2019.
//  Copyright © 2019 DrEMartstud. All rights reserved.
//

import UIKit
struct FontStyleData{
    let font: UIFont
    let color: UIColor
}
enum Font {
    static let h1 = FontStyleData(font: FontStyle.title, color: Color.black)
    static let body = FontStyleData(font: FontStyle.description, color: Color.gray)
}
