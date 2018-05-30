//
//  ViewController.swift
//  WeatherApp
//
//  Created by Aina on 19/05/18.
//  Copyright © 2018 Aina. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var hiloLabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var refreshButton: UIButton!
    
    var locationManager : CLLocationManager?
    var userLocation:CLLocation?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentLocation()
    }
    
    func getCurrentLocation() {
        locationManager = CLLocationManager()
        locationManager?.delegate = self
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.requestAlwaysAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager?.startUpdatingLocation()
            //locationManager?.startUpdatingHeading()
        }
    }
   
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        userLocation = locations[0] as CLLocation
        
        // Call stopUpdatingLocation() to stop listening for location updates,
        // other wise this function will be called every time when user location changes.
        
        // manager.stopUpdatingLocation()
        if let location = userLocation {
            print("user latitude = \(location.coordinate.latitude)")
            print("user longitude = \(location.coordinate.longitude)")
            getWeatherUpdate(forLocation : location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to update location with error\(error.localizedDescription)")
    }
    
    
    func tempratureInFahrenheit(val : Double?) -> String {
        if var val = val {
            val = (val * 9)/5 - 459.67
            let Ftemp = String(format: "%.2f", ceil(val*100)/100)
            return Ftemp
        }
        return "0"
    }
    
    func getWeatherUpdate(forLocation location : CLLocation) {
        
        let currentWeatherUrl = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=def2ff83153a43e60b29fc4ea965290c" )
        WeatherApi.sharedInstance.getCurrentWeatherData(withUrl: currentWeatherUrl!) { (model) in
            DispatchQueue.main.async {
            self.cityLabel.text = model.name
                self.hiloLabel.text = "\(self.tempratureInFahrenheit(val: model.main?.temp_max))°/\(self.tempratureInFahrenheit(val: model.main?.temp_min))°"
            self.tempLabel.text = "\(self.tempratureInFahrenheit(val: model.main?.temp))°"
            self.conditionLabel.text = model.weather?.first?.description
            let image = model.imageName(forIcon: (model.weather?.first?.icon)!)
            self.iconImageView.image = UIImage(named: image)
            }
        }
    }
    
    @IBAction func didTapRefreshButton(_ sender: UIButton) {
        if let location = userLocation {
            getWeatherUpdate(forLocation: location)
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

}
