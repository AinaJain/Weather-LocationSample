//
//  WeatherConditionModel.swift
//  WeatherApp
//
//  Created by Aina on 19/05/18.
//  Copyright © 2018 Aina. All rights reserved.
//

import UIKit

public class Coord
{
    var lon : Int?
    var lat : Int?
}

public class Weather
{
    var id : Int?
    var main : String?
    var description : String?
    var icon : String?
}

public class Main
{
    var humidity : Int?
    var temp : Double?
    var pressure : Double?
    var grnd_level : Double?
    var temp_min : Double?
    var temp_max : Double?
    var sea_level : Double?
}

public class Wind
{
    var speed : Double?
    var deg : Double?
}

public class Rain
{
    var h : Double?
}

public class Clouds
{
    var all : Int?
}

public class Sys
{
    var message : Double?
    var country : String?
    var sunrise : Int?
    var sunset : Int?
}

public class WeatherConditionModel
{
    var coord : Coord?
    var base : String?
    var main : Main?
    var wind : Wind?
    var rain : Rain?
    var clouds : Clouds?
    var dt : Int?
    var sys : Sys?
    var id : Int?
    var name : String?
    var cod : Int?
    var weather : Array<Weather>?

    func imageMap() -> [String:String] {
        let imageMap = [
            "01d" : "weather-clear",
            "02d" : "weather-few",
            "03d" : "weather-few",
            "04d" : "weather-broken",
            "09d" : "weather-shower",
            "10d" : "weather-rain",
            "11d" : "weather-tstorm",
            "13d" : "weather-snow",
            "50d" : "weather-mist",
            "01n" : "weather-moon",
            "02n" : "weather-few-night",
            "03n" : "weather-few-night",
            "04n" : "weather-broken",
            "09n" : "weather-shower",
            "10n" : "weather-rain-night",
            "11n" : "weather-tstorm",
            "13n" : "weather-snow",
            "50n" : "weather-mist",
            ]
        return imageMap;
    }
    
    func imageName(forIcon iconName : String) -> String {
        return self.imageMap()[iconName]!
    }
    
    func dateTransformer(with timeInterval:TimeInterval) -> Date {
        let transDate = Date.init(timeIntervalSince1970: timeInterval)
        return transDate
    }
    
    func getSunriseTime(with timeInterval: TimeInterval) -> Date {
        return dateTransformer(with: timeInterval)
    }
    
    func getSunsetTime(with timeInterval: TimeInterval) -> Date {
        return dateTransformer(with: timeInterval)
    }
}





