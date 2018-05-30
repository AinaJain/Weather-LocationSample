//
//  WeatherApi.swift
//  WeatherApp
//
//  Created by Aina on 19/05/18.
//  Copyright © 2018 Aina. All rights reserved.
//

import UIKit

enum Result <T>{
    case Success(T)
    case Error(String)
}

class WeatherApi: NSObject {
    
    static let sharedInstance = WeatherApi()
    
    
//    func getCurrentWeatherData(withUrl url : URL, completion: @escaping (Result<[String: AnyObject]>) -> Void) {
//    }
    func getCurrentWeatherData(withUrl url : URL, completion : @escaping (WeatherConditionModel) -> ()) {
        let task = URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            if let data = data {
                let obj = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves)
                if let obj = obj as? [String:Any] {
                    self.parseDictionary(withJsonData: obj, completion: { (model) in
                        completion(model)
                    })
                }
            }
        }
        task.resume()
    }
    
    func parseDictionary(withJsonData obj: [String:Any], completion : (WeatherConditionModel) -> () ) {
        let keys = obj.keys
        let weatherInfo = WeatherConditionModel()
        for (_,element) in keys.enumerated() {
            if let stringValue = obj[element] as? String {
                print("String Obj== \(element):\(stringValue)")
                switch element {
                case "name" :
                    weatherInfo.name = stringValue
                case "base" :
                    weatherInfo.base = stringValue
                default :
                    break
                }
            }
            else if let intValue = obj[element] as? Int {
                print("Int Obj== \(element):\(intValue)")
                switch element {
                case "dt" :
                    weatherInfo.dt = intValue
                case "id" :
                    weatherInfo.id = intValue
                case "cod" :
                    weatherInfo.cod = intValue
                default :
                    break
                }
            }
            else if let subValue = obj[element] as? [String:Any]{
                print("Dict Obj== \(element):\(subValue)")
                
                switch element {
                case "coord" :
                    let coordInfo = Coord()
                    let subKeys = subValue.keys
                    for (_,element) in subKeys.enumerated() {
                        if let intValue = subValue[element] as? Int {
                            switch element {
                            case "lat" :
                                coordInfo.lat = intValue
                            case "lon" :
                                coordInfo.lon = intValue
                            default :
                                break
                            }
                            
                        }}
                    weatherInfo.coord = coordInfo
                case "main" :
                    let mainInfo = Main()
                    let subKeys = subValue.keys
                    for (_,element) in subKeys.enumerated() {
                        if let intValue = subValue[element] as? Int {
                            switch element {
                            case "humidity" :
                                mainInfo.humidity = intValue
                            default :
                                break
                            }
                        }
                        else if let dblValue = subValue[element] as? Double {
                            switch element {
                            case "temp" :
                                mainInfo.temp = dblValue
                            case "pressure" :
                                mainInfo.pressure = dblValue
                            case "grnd_level" :
                                mainInfo.grnd_level = dblValue
                            case "temp_min" :
                                mainInfo.temp_min = dblValue
                            case "temp_max" :
                                mainInfo.temp_max = dblValue
                            case "sea_level" :
                                mainInfo.sea_level = dblValue
                            default :
                                break
                            }
                        }
                    }
                    weatherInfo.main = mainInfo
                case "wind" :
                    let windInfo = Wind()
                    let subKeys = subValue.keys
                    for (_,element) in subKeys.enumerated() {
                        if let dblValue = subValue[element] as? Double {
                            switch element {
                            case "speed" :
                                windInfo.speed = dblValue
                            case "deg" :
                                windInfo.deg = dblValue
                            default :
                                break
                            }
                        }
                    }
                    weatherInfo.wind = windInfo
                case "clouds" :
                    let cloudInfo = Clouds()
                    let subKeys = subValue.keys
                    for (_,element) in subKeys.enumerated() {
                        if let intValue = subValue[element] as? Int {
                            switch element {
                            case "all" :
                                cloudInfo.all = intValue
                            default :
                                break
                            }
                        }
                    }
                    weatherInfo.clouds = cloudInfo
                case "sys" :
                    let sysInfo = Sys()
                    let subKeys = subValue.keys
                    for (_,element) in subKeys.enumerated() {
                        if let intValue = subValue[element] as? Int {
                            switch element {
                            case "sunrise" :
                                sysInfo.sunrise = intValue
                            case "sunset" :
                                sysInfo.sunset = intValue
                            default :
                                break
                            }
                        }
                        else if let dblValue = subValue[element] as? Double {
                            switch element {
                            case "message" :
                                sysInfo.message = dblValue
                            default :
                                break
                            }
                        }
                        else if let strValue = subValue[element] as? String {
                            switch element {
                            case "country" :
                                sysInfo.country = strValue
                            default :
                                break
                            }
                        }
                    }
                    weatherInfo.sys = sysInfo
                default :
                    break
                }
            }
            else {
                var weatherArray = [Weather]()
                if let subArray = obj[element] as? [Any]{
                    for (_,element) in subArray.enumerated() {
                        if let dictValue = element as? [String:Any] {
                            let weatherInfo = Weather()
                            let subKeys = dictValue.keys
                            for (_,ele) in subKeys.enumerated() {
                                if let intValue = dictValue[ele] as? Int {
                                    switch ele {
                                    case "id" :
                                        weatherInfo.id = intValue
                                    default :
                                        break
                                    }
                                }
                                else if let strValue = dictValue[ele] as? String {
                                    switch ele {
                                    case "description" :
                                        weatherInfo.description = strValue
                                    case "main" :
                                        weatherInfo.main = strValue
                                    case "icon" :
                                        weatherInfo.icon = strValue
                                    default :
                                        break
                                    }
                                }
                            }
                            weatherArray.append(weatherInfo)
                        }
                    }
                    weatherInfo.weather = weatherArray
                    print("Array Obj== \(element):\(weatherArray)")
                }
            }
        }
        completion(weatherInfo)
    }
}
