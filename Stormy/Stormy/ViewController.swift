//
//  ViewController.swift
//  Stormy
//
//  Created by Prasanth Baireddy on 10/15/15.
//  Copyright © 2015 Prasanth Baireddy. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var currentTemperatureLabel: UILabel?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var currentHumidityLabel: UILabel?
    @IBOutlet weak var currentPrecipitationLabel: UILabel?
    @IBOutlet weak var currentWeatherIcon: UIImageView?
    @IBOutlet weak var currentWeatherSummary: UILabel?
   
    @IBOutlet weak var refreshButton: UIButton!
    
    private let forecastAPIKey = "c56e19a165e13b70b8d0145591c00c4e"
    let coordinate: (lat: Double, lon: Double) = (37.8267,-122.423)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
                    retrieveWeatherForecast()
                }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 func retrieveWeatherForecast()
 {
    let forecastService = ForecastService(APIKey: forecastAPIKey)
    forecastService.getForecast(coordinate.lat, lon:coordinate.lon) {
        (let currently) in
        if let currentWeather = currently {
            
            dispatch_async(dispatch_get_main_queue()) {
                
                
                if let temperature = currentWeather.temperature
                {
                    self.currentTemperatureLabel?.text = "\(temperature)º"
                    print(temperature)
                }
                
                if let humidity = currentWeather.humidity
                {
                    
                    self.currentHumidityLabel?.text = "\(humidity)%"
                    print(humidity)
                }
                
                if let precipitation = currentWeather.precipProbability
                {
                    self.currentPrecipitationLabel?.text = "\(precipitation)%"
                    print(precipitation)
                    
                }
                
                if let icon = currentWeather.icon
                {
                    self.currentWeatherIcon?.image = icon
                    
                }
                
                if let summary = currentWeather.summary
                {
                    self.currentWeatherSummary?.text = summary
                }
                
                self.toggleRefreshAnimation(false)
            }
        }
    }

    
    }
    
    
    @IBAction func refreshWeather() {
        toggleRefreshAnimation(true)
        retrieveWeatherForecast()
    }
    
    func toggleRefreshAnimation(on: Bool)
    {
        refreshButton?.hidden = on
        
        if on{
        activityIndicator.startAnimating()
        }
        else
        {
            activityIndicator.stopAnimating()
        }
    }
    
}

