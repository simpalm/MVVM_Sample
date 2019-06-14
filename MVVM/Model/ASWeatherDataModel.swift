//
//  ASWeatherDataModel.swift
//  MVVM
//
//  Created by Aman Sinha on 02/05/19.
//  Copyright © 2019 simplam. All rights reserved.
//

import UIKit


class ASWeatherDataModel : Codable{

    var main : Mainn?
    var temperature :Int = 0
    var condition : Int = 0
    var weather : [Weather]?
    var name : String?
    var city : String = ""
    var weatherIconName : String? = ""
    
    enum CodingKeys: String, CodingKey {
        case main
        case name
        case weather
    }
    
    init(main:Mainn,weather:[Weather],name:String,temperature:Int) {
        self.main = main
        self.weather = weather
        self.name = name
    }
    
    
//    init(json: JSON) {
//
//        let tempResult = json["main"]["temp"].doubleValue
//
//        temperature = Int(tempResult - 273.15)
//
//        city = json["name"].stringValue
//
//        condition = json["weather"][0]["id"].intValue
//
//        weatherIconName = updateWeatherIcon(condition: condition)
//
//    }
    
   
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
    
    class Mainn: Codable {
        var temp : Double = 0
        enum CodingKeys: String, CodingKey {
            case temp
        }
        init(temp: Double) {
            self.temp = temp
        }
    }
    class Weather: Codable {
        
        var id : Int = 0
        enum CodingKeys: String, CodingKey {
            case id
        }
        init(id: Int) {
            self.id = id
        }
    }
}
