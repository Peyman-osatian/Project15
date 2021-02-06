//
//  WeatherDataModel.swift
//  Project15
//
//  Created by Peyman Osatian on 2020-11-21.
//  Copyright © 2020 Peyman Osatian. All rights reserved.
//
import UIKit

class WeatherDataModel {
 
    //Declare your model variables here
    var temperature : Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherIconName : String = ""
    
    
    //This method turns a condition code into the name of the weather condition image
    
    func updateWeatherIcon(condition: Int) -> String {
        
    switch (condition) {
    
        case 0...300 :
            return "rainy"
        
        case 301...500 :
            return "rainy"
        
        case 501...600 :
            return "rainy"
        
        case 601...700 :
            return "snowy"
        
        case 701...771 :
            return "cloudy1"
        
        case 772...799 :
            return "rainy"
        
        case 800 :
            return "sun"
        
        case 801...804 :
            return "cloudy1"
        
        case 900...903, 905...1000  :
            return "rainy"
        
        case 903 :
            return "snowy"
        
        case 904 :
            return "sun"
        
        default :
            return "dunno"
        }

    }
}
