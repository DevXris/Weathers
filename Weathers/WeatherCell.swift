//
//  WeatherCell.swift
//  Weathers
//
//  Created by Chris Huang on 23/09/2016.
//  Copyright © 2016 Chris Huang. All rights reserved.
//

import UIKit

class WeatherCell: UITableViewCell {

    // MARK: Outlets and Properties
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var dayLabel: UILabel!
    @IBOutlet weak var weatherType: UILabel!
    @IBOutlet weak var highTemp: UILabel!
    @IBOutlet weak var lowTemp: UILabel!
    
    // MARK: Functions
    
    func configureCell(forecast: Forecast) {
        lowTemp.text = String(format: "%.1f°", forecast.lowTemp)
        highTemp.text = String(format: "%.1f°", forecast.highTemp)
        weatherType.text = forecast.weatherType
        dayLabel.text = forecast.date
        weatherIcon.image = UIImage(named: forecast.weatherType)
    }
}
