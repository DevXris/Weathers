//
//  Forecast.swift
//  Weathers
//
//  Created by Chris Huang on 22/09/2016.
//  Copyright © 2016 Chris Huang. All rights reserved.
//

import UIKit
import Alamofire

struct Forecast {
    
    // MARK: Properties
    
    private var _date: String!
    private var _weatherType: String!
    private var _highTemp: Double!
    private var _lowTemp: Double!
    
    var date: String { return _date ?? "" }
    var weatherType: String { return _weatherType ?? "" }
    var highTemp: Double { return _highTemp ?? 0 }
    var lowTemp: Double { return _lowTemp ?? 0 }
    
    // MARK: Initialization
    
    init(weatherDict: [String: AnyObject]) {
        
        if let temp = weatherDict["temp"] as? [String: AnyObject],
           let min = temp["min"] as? Double,
           let max = temp["max"] as? Double {
            var kelvinToCelsius = min - 273.15
            self._lowTemp = Double(round(10 * kelvinToCelsius) / 10)
            kelvinToCelsius = max - 273.15
            self._highTemp = Double(round(10 * kelvinToCelsius) / 10)
        }
        
        if let weather = weatherDict["weather"] as? [[String: AnyObject]] {
            if let type = weather[0]["main"] as? String {
                self._weatherType = type
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .full
            dateFormatter.dateFormat = "EEEE"
            dateFormatter.timeStyle = .none
            self._date = unixConvertedDate.dateOfTheWeek()
        }
    }
}

extension Date {
    func dateOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
}
