//
//  ViewController.swift
//  Project15
//
//  Created by Peyman Osatian on 2020-11-21.
//  Copyright © 2020 Peyman Osatian. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class CitySelectorViewController: UIViewController, ChangeCityDelegate, CLLocationManagerDelegate {

    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var details: UIButton!
    @IBOutlet weak var city: UILabel!
    
    let WEATHER_URL = "http://api.openweathermap.org/data/2.5/weather"
    let APP_ID = "c7bbb87a382344275d24fa90e37ca9c7"
    let weatherDataModel = WeatherDataModel()
    
    let locationManager = CLLocationManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
    
    @IBAction func showDetails(_ sender: Any) {
        performSegue(withIdentifier: "openWeather", sender: self)
    }
    
    
    func getWeatherData(url: String, parameters: [String: String]) {
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON {
            response in
            if response.result.isSuccess {
                
                print("Success! Got the weather data")
                print(response.result.value)
                let weatherJSON : JSON = JSON(response.result.value!)
                
                self.updateWeatherData(json: weatherJSON)
                
            }
            else {
                print("Error \(String(describing: response.result.error))")
                self.city.text = "Connection Issues"
            }
        }
        
    }
    
    func updateWeatherData(json : JSON) {
    
        let tempResult = json["main"]["temp"].doubleValue
    
            weatherDataModel.temperature = Int(tempResult - 273.15)
    
            weatherDataModel.city = json["name"].stringValue
    
            weatherDataModel.condition = json["weather"][0]["id"].intValue
    
            weatherDataModel.weatherIconName = weatherDataModel.updateWeatherIcon(condition: weatherDataModel.condition)
    
    
            updateUIWithWeatherData()
        }
    
    func updateUIWithWeatherData() {
        print(weatherDataModel.weatherIconName)
    
        city.text = weatherDataModel.city
        image.image = UIImage(named: weatherDataModel.weatherIconName)

    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            self.locationManager.stopUpdatingLocation()
            
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : APP_ID]
            
            getWeatherData(url: WEATHER_URL, parameters: params)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        city.text = "Location Unavailable"
    }
    
    func userEnteredANewCityName(city: String) {
        
        let params : [String : String] = ["q" : city, "appid" : APP_ID]
        
        getWeatherData(url: WEATHER_URL, parameters: params)
        
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "openWeather" {
            let target = segue.destination as? WeatherConditionViewController
            target?.weather = weatherDataModel;
            
        
        } else if (segue.identifier == "openCity") {
            let destinationVC = segue.destination as! CityViewController
            destinationVC.delegate = self
            
        }
    }
    
}

