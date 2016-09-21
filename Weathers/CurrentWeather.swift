//
//  CurrentWeather.swift
//  Weathers
//
//  Created by Chris Huang on 9/20/16.
//  Copyright © 2016 Chris Huang. All rights reserved.
//

import Foundation
import Alamofire

typealias Completed = () -> () // used for callback

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
    
//    mutating func downloadWeatherDetails(completed: @escaping Completed) {
//        let currentWeatherURL = OpenWeather.instance.url!
//        Alamofire.request(currentWeatherURL).responseJSON { (response) in
//            if response.result.isSuccess {
//                print(response.result)
//            } else {
//                print(response.debugDescription)
//            }
//            completed()
//        }
//    }
}
