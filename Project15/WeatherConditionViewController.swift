//
//  WeatherConditionViewController.swift
//  Project15
//
//  Created by Peyman Osatian on 2020-11-21.
//  Copyright © 2020 Peyman Osatian. All rights reserved.
//

import UIKit

class WeatherConditionViewController: UIViewController {
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var day: UILabel!
    @IBOutlet weak var background: UIImageView!
    var weather = WeatherDataModel();
    
    override func viewDidLoad() {
        super.viewDidLoad();
        city.text = weather.city
        temp.text = "\(weather.temperature)°"
        image.image = UIImage(named: weather.weatherIconName)
        day.text = Date().dayOfWeek()!
        background.image = UIImage(named: (weather.weatherIconName + "Bg"))
        background.alpha = 0.2
    }
    


}

extension Date {
    func dayOfWeek() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self).capitalized
    }
}

