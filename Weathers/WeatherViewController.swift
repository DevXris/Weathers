//
//  ViewController.swift
//  Weathers
//
//  Created by Chris Huang on 9/20/16.
//  Copyright © 2016 Chris Huang. All rights reserved.
//

import UIKit

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

    // MARK: ViewController Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        currentWeather.downloadWeatherDetails { (weather) in
            print("Got data callback!")
            self.currentWeather = weather // set self to callback data
            self.updateUI()
        }
    }
    
    // MARK: Functions
    func updateUI() {
        dateLabel.text = currentWeather.date
        currentTempLabel.text = String(currentWeather.currentTemp)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "WeatherCell", for: indexPath)
        return cell
    }
    
    // MARK: UITableViewDelegate

}

