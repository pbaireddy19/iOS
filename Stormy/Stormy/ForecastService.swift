//
//  ForecastService.swift
//  Stormy
//
//  Created by Prasanth Baireddy on 10/16/15.
//  Copyright © 2015 Prasanth Baireddy. All rights reserved.
//

import Foundation

struct ForecastService
{
    let forecastAPIKey: String
    let forecastBaseURL: NSURL?
    

    init(APIKey: String)
    {
        forecastAPIKey = APIKey
        forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    }
    
    
    func getForecast(lat: Double, lon: Double, completion: (CurrentWeather? -> Void))
    {
        if let forecastURL = NSURL(string: "\(lat),\(lon)", relativeToURL: forecastBaseURL)
        {
            let networkOperation = NetworkOperation(url: forecastURL)
            
            networkOperation.downloadJSONFromURL {
                (let jsonDictionary) in
                let currentWeather = self.currentWeatherFromJSON(jsonDictionary)
                completion(currentWeather)
            }
        
        } else {
        
            print("Could not construct a valid URL")
        }
    
    }
    
    
    
    func currentWeatherFromJSON(jsonDictionary: [String: AnyObject]?) -> CurrentWeather?
    {
        if let currentWeatherDictionary = jsonDictionary?["currently"] as? [String: AnyObject]
        {
            return CurrentWeather(weatherDictionary: currentWeatherDictionary)
        
        } else{
        
        return nil
        }
        
    }
    
    
}