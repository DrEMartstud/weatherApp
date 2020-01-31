//
//  SearchView.swift
//  WeatherApp
//
//  Created by DrEMartstud on 31.01.2020.
//  Copyright © 2020 DrEMartstud. All rights reserved.
//

import UIKit

class SearchView:UIView {

    var cornerRadius: CGFloat = 0.5 {
         didSet {
             self.layer.cornerRadius = cornerRadius
         }
     }
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
}
