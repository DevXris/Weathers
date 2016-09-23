//
//  ViewController.swift
//  Weathers
//
//  Created by Chris Huang on 9/20/16.
//  Copyright © 2016 Chris Huang. All rights reserved.
//

import UIKit
import Alamofire

class WeatherViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // MARK: Outlets and Properteis
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var currentTempLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    @IBOutlet weak var currentWeatherImage: UIImageView!
    @IBOutlet weak var currentWeatherTypeLabel: UILabel!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 80
        }
    }
    
    var currentWeather = CurrentWeather()
    var forecasts = [Forecast]()

    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentWeather.downloadWeatherDetails { (weather) in
            if let weather = weather as? CurrentWeather {
                print("Got current weather data callback!")
                self.currentWeather = weather // set self to callback data
                self.downloadForecastData(completed: { _ in
                    self.updateUI()
                    self.tableView.reloadData()
                })
            } else {
                print("Can't get current weather data!")
            }
        }
    }
    
    // MARK: Functions
    
    func downloadForecastData(completed: @escaping Completed) {
        var forecastURL = OpenWeather.instance
        forecastURL.urlType = .Forecast
        
        Alamofire.request(forecastURL.url).responseJSON { (response) in
            if response.result.isSuccess {
                
                // Parse data from OpenWeatherMap forecast data
                let result = response.result.value
                if let dict = result as? [String: AnyObject],
                   let lists = dict["list"] as? [[String: AnyObject]] {
                    for list in lists {
                        let forecast = Forecast(weatherDict: list)
                        self.forecasts.append(forecast)
//                        print(list)
                    }
                }
            } else {
                print(response.debugDescription)
            }
            completed(nil)
        }
    }
    
    func updateUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = String(format: "%.1f°", currentWeather.currentTemp)
        locationLabel.text = currentWeather.cityName
        currentWeatherImage.image = UIImage(named: currentWeather.weatherType)
        currentWeatherTypeLabel.text = currentWeather.weatherType
    }

    // MARK: UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if !forecasts.isEmpty {
            if let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath) as? WeatherCell {
                let forecast = forecasts[indexPath.row]
                cell.configureCell(forecast: forecast)
                return cell
            }
        }
        return UITableViewCell()
    }
    
    // MARK: UITableViewDelegate

}

