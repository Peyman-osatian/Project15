//
//  CityViewController.swift
//  Project15
//
//  Created by Peyman Osatian on 2020-11-21.
//  Copyright © 2020 Peyman Osatian. All rights reserved.
//

import UIKit

protocol ChangeCityDelegate {
    func userEnteredANewCityName(city: String)
}

class CityViewController: UIViewController {
    var delegate : ChangeCityDelegate?
    @IBOutlet weak var search: UIButton!
    @IBOutlet weak var city: UILabel!
    @IBOutlet weak var cityTxt: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        cityTxt.placeholder = "Enter City"
        cityTxt.delegate = self
        if (cityTxt.text == "") {
            search.isHidden = true
        }
    }
    
    @IBAction func search(_ sender: AnyObject) {
        let cityName = cityTxt.text!
        delegate?.userEnteredANewCityName(city: cityName)
        navigationController?.popViewController(animated: true)

        dismiss(animated: true, completion: nil)    }
    

    @IBAction func backButtonPressed(_ sender: AnyObject) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension CityViewController: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        search.isHidden = false
        return true
    }
    
}
