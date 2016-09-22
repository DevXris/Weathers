//
//  Constants.swift
//  Weathers
//
//  Created by Chris Huang on 9/20/16.
//  Copyright © 2016 Chris Huang. All rights reserved.
//

import Foundation

enum URLType: String {
    case Today
    case Forecast
}

struct OpenWeather {
    
    // MARK: Private properites
    
    private let _APIKey = "54966031ac95a147973ed2629bf464da"
    private var urlComponentsPath: String {
        switch _urlType {
        case .Today : return "/data/2.5/weather"
        case .Forecast : return "/data/2.5/forecast/daily"
        }
    }
    
    private var urlQueryItems: [URLQueryItem] {
        switch _urlType {
        case .Today :
            return [URLQueryItem(name: "lat", value: String(self._latitude)),
                    URLQueryItem(name: "lon", value: String(self._longitude)),
                    URLQueryItem(name: "appid", value: self._APIKey)]
        case .Forecast :
            return [URLQueryItem(name: "lat", value: String(self._latitude)),
                    URLQueryItem(name: "lon", value: String(self._longitude)),
                    URLQueryItem(name: "cnt", value: "10"),
                    URLQueryItem(name: "mode", value: "json"),
                    URLQueryItem(name: "appid", value: self._APIKey)]
        }
    }
    
    private lazy var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "http"
        components.host = "api.openweathermap.org"
        components.path = self.urlComponentsPath
        components.queryItems = self.urlQueryItems
        return components
    }()
    
    private var _latitude: Double! { didSet { updateURLs() } }
    private var _longitude: Double!  { didSet { updateURLs() } }
    private var _urlType: URLType { didSet { updateURLs() } }
    private var _URLs: URL!
    
    private mutating func updateURLs() {
        urlComponents.path = urlComponentsPath
        urlComponents.queryItems = urlQueryItems
        _URLs = urlComponents.url
    }
    
    // MARK: Properties
    
    var latitude: Double {
        get { return _latitude }
        set { _latitude = newValue }
    }
    
    var longitude: Double {
        get { return _longitude }
        set { _longitude = newValue }
    }
    
    var urlType: URLType {
        get { return _urlType }
        set { _urlType = newValue }
    }
    
    var url: URL { return _URLs }
    
    static var instance = OpenWeather()

    // MARK: Initialization
    
    init(latitude: Double, longitude: Double, urlType: URLType) {
        _latitude = latitude
        _longitude = longitude
        _urlType = urlType
        _URLs = urlComponents.url
    }
    
    init() {
        _latitude = -36
        _longitude = 123
        _urlType = .Today
        _URLs = urlComponents.url
    }
}



