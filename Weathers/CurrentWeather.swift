//
//  CurrentWeather.swift
//  Weathers
//
//  Created by Chris Huang on 9/20/16.
//  Copyright © 2016 Chris Huang. All rights reserved.
//

import Foundation
import Alamofire

struct CurrentWeather {
    
    private var _cityName: String!
    private var _weatherType: String!
    private var _currentTemp: Double!
    
    var cityName: String { return _cityName ?? "" }
    var weatherType: String { return _weatherType ?? "" }
    var currentTemp: Double { return _currentTemp ?? 0 }
    var date: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .none
        let currentDate = dateFormatter.string(from: Date())
        return "Today, \(currentDate)"
    }
    
    mutating func downloadWeatherDetails(completed: @escaping Completed) {
        let currentWeatherURL = OpenWeather.instance.url
        
        var weatherCopy = self // create a copy of self(it's a struct) and send data to callback

        Alamofire.request(currentWeatherURL).responseJSON { (response) in
            if response.result.isSuccess {
                
                // Parse data from OpenWeatherMap current data
                let result = response.result.value
                if let dict = result as? [String: AnyObject],
                   let name = dict["name"] as? String,
                   let weather = dict["weather"] as? [[String: AnyObject]],
                   let main = dict["main"] as? [String: AnyObject] {
                    
                    weatherCopy._cityName = name
                    
                    if let type = weather[0]["main"] as? String {
                        weatherCopy._weatherType = type
                    }
                    
                    if let temp = main["temp"] as? Double {
                        let kelvinToCelsius = temp - 273.15
                        // let kelvinToFahrenheitPredivision = temp * 9/5 - 459.67
                        // let kelvinToFahrenheit = Double(round(10 * kelvinToFahrenheitPredivision) / 10)
                        weatherCopy._currentTemp = Double(round(10 * kelvinToCelsius) / 10)
                    }
                }
                
            } else {
                print(response.debugDescription)
            }
            completed(weatherCopy)
        }
    }
}
