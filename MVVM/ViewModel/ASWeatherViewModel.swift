//
//  ASWeatherViewModel.swift
//  MVVM
//
//  Created by Aman Sinha on 02/05/19.
//  Copyright © 2019 simplam. All rights reserved.
//

import Foundation

//b2dfc1f1a3eef959d4138a4606f1d196
let APP_ID = "1b09973cd675ade32a34001a9b6814a6"
let WEATHER_URL = "https://api.openweathermap.org/data/2.5/weather?"

public class ASWeatherViewModel{
  
    // GET: Detail Through City Name
    /*-------------------------------------------------------------*/
    func userEnteredANewCity(city: String,withCompletionHandler:@escaping(ASWeatherDataModel?)->Void) {
        
        let params : [String : String] = ["q" : city, "APPID" : APP_ID]
  //      var weather : ASWeatherDataModel!
        ASConnection.getWeather(url: WEATHER_URL, parameters: params) { (result, error) in
       
  ///     weather  = result!
            
             withCompletionHandler(result!)
            
        }
    }
    
    // GET: Detail Through LAT and LONG
    /*-------------------------------------------------------------*/
    func userLatLongDetail(lat : String,lon:String,withCompletionHandler:@escaping(ASWeatherDataModel?)->Void) {
        
        let params : [String : String] = ["lat" : lat, "lon" : lon, "APPID" : APP_ID]
       
//        var weather : ASWeatherDataModel!
        ASConnection.getWeather(url: WEATHER_URL, parameters: params) { (result, error) in
            
//            weather  = ASWeatherDataModel(json: result!)
            print(result!.name!)
            print(result!.main!.temp)
            print(result!.weather![0].id)
           withCompletionHandler(result!)
            
        }
    }
    //GET: Fahrenheit
    /*-------------------------------------------------------------*/
    func updateTemperatureToFahrenheit(celsius :Int)->Int{
        
        return Int((celsius*9/5)+32)
    }
    func updateWeatherIcon(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "tstorm1"
            
        case 301...500 :
            return "light_rain"
            
        case 501...600 :
            return "shower3"
            
        case 601...700 :
            return "snow4"
            
        case 701...771 :
            return "fog"
            
        case 772...799 :
            return "tstorm3"
            
        case 800 :
            return "sunny"
            
        case 801...804 :
            return "cloudy2"
            
        case 900...903, 905...1000  :
            return "tstorm3"
            
        case 903 :
            return "snow5"
            
        case 904 :
            return "sunny"
            
        default :
            return "dunno"
        }
    }
    
}
