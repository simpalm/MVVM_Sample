//
//  ASCityViewController.swift
//  MVVM
//
//  Created by Aman Sinha on 02/05/19.
//  Copyright © 2019 simplam. All rights reserved.
//

import UIKit


//Write the protocol declaration here:

protocol CityDelegate {
    
    func userEnteredNewCity(city: String)
    
}

class ASCityViewController: UIViewController {
    
    var delegate : CityDelegate?
    
    @IBOutlet weak var changeCityTextField: UITextField!
 
    
    //Getting Weather.
    /*-------------------------------------------------------------*/
    @IBAction func getWeatherPressed(_ sender: AnyObject) {

        let cityName = changeCityTextField.text!
        
        delegate?.userEnteredNewCity(city: cityName)

        self.navigationController?.popViewController(animated: true)
        
    }
    
    
    //Back Button.
    @IBAction func backButtonPressed(_ sender: AnyObject) {
         self.navigationController?.popViewController(animated: true)
    }
}
