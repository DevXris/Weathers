//
//  WeatherData.swift
//  Weathers
//
//  Created by Chris Huang on 23/09/2016.
//  Copyright © 2016 Chris Huang. All rights reserved.
//

import Foundation

typealias Completed = (_ weather: WeatherData?) -> () // used for callback

protocol WeatherData { }

extension CurrentWeather: WeatherData { }
extension Forecast: WeatherData { }
