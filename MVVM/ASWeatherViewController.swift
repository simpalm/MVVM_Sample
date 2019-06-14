//
//  ASWeatherViewController.swift
//  MVVM
//
//  Created by Aman Sinha on 02/05/19.
//  Copyright © 2019 simplam. All rights reserved.
//

import UIKit
import CoreLocation

class ASWeatherViewController: UIViewController, CLLocationManagerDelegate, CityDelegate {
    
    @IBOutlet weak var faren: UISwitch!
    @IBAction func clickNext(_ sender: Any) {
        self.performSegue(withIdentifier: "next", sender: nil)
    }
    
    @IBAction func `switch`(_ sender: UISwitch) {
        
        if sender.isOn {
            temperatureLabel.text = "\(Int((weatherData!.main!.temp) - 273.15))℃"
       }
        else{
            // CALL: calling view model.
            temperatureLabel.text = "\(weather.updateTemperatureToFahrenheit(celsius: Int((weatherData!.main!.temp) - 273.15)))℉"
        }
    }
    //TODO: Declare instance variables here
    let locationManager2 = CLLocationManager()
    
    @IBOutlet weak var weatherIcon: UIImageView!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var button: UIButton!
    var weather : ASWeatherViewModel!
    var weatherData : ASWeatherDataModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //TODO:Set up the location manager here.
        locationManager2.delegate = self
        locationManager2.desiredAccuracy = kCLLocationAccuracyBest
        locationManager2.requestWhenInUseAuthorization()
        locationManager2.startUpdatingLocation()
        weather = ASWeatherViewModel()
    
    }
    
    //MARK: - UI Updates
    /*-------------------------------------------------------------*/
   
    func updateUIWithWeatherData(weather : ASWeatherDataModel!) {
        DispatchQueue.main.sync {
            self.weatherData = weather!
            self.cityLabel.text = self.weatherData.name
            self.temperatureLabel.text = "\(Int((weather!.main!.temp) - 273.15))℃"
            let image = self.weather.updateWeatherIcon(condition: weather!.weather![0].id)
            self.weatherIcon.image = UIImage(named: image)
        }
    }
    
    //MARK: - Location Manager Delegate Methods
    /*-------------------------------------------------------------*/
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0 {
            
            self.locationManager2.stopUpdatingLocation()
            print("longitude = \(location.coordinate.longitude), latitude = \(location.coordinate.latitude)")
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            // CALL: calling view model.
            weather.userLatLongDetail(lat: latitude, lon: longitude) { data in
                self.updateUIWithWeatherData(weather: data)
            }
                    }
    }
    
    // didFailWithError method
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
        cityLabel.text = "Location Unavailable"
        let latitude = String("22.719568")
        let longitude = String("75.857727")
        // CALL: calling view model.
        
        weather.userLatLongDetail(lat: latitude, lon: longitude) { data in
            self.updateUIWithWeatherData(weather: data!)
        }
    }
    
    //MARK: - Change City Delegate methods
    /*-------------------------------------------------------------*/
    
    func userEnteredNewCity(city: String) {
    // CALL: calling view model.
        weather.userEnteredANewCity(city: city) { data in
            self.updateUIWithWeatherData(weather: data!)
            if self.faren.isOn{
                self.temperatureLabel.text = "\(Int((self.weatherData!.main!.temp) - 273.15))°C"
            }
            else{
                // CALL: calling view model.
                self.temperatureLabel.text = "\(self.weather.updateTemperatureToFahrenheit(celsius: Int((self.weatherData!.main!.temp) - 273.15)))℉"
            }
        }
    }
    
// PrepareForSegue Method
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "next" {
            let destinationVC = segue.destination as! ASCityViewController
            destinationVC.delegate = self
            
        }
    }
}











