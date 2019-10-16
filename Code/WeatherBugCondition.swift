//
//  weatherBugCondition.swift
//  WeatherBug
//
//  Created by Germaine Uwimpuhwe on 4/28/19.
//  Copyright © 2019 Germaine Uwimpuhwe. All rights reserved.
//

import Foundation
class WeatherBugCondition {
    // Declare your model variables
    var temperature: Int = 0
    var condition : Int = 0
    var city : String = ""
    var weatherImageName: String = ""
    var weatherCondition: String = ""
    var minTemp : Int = 0
    var maxTemp : Int = 0
    
    // This method turns a condition code into the name of the weather condition image.
    func updateWeatherBugCondition(condition: Int) -> String{
        switch (condition) {
            case 0...300:
            return "Thunderstoms"
            case 301...500:
            return "Heavy showers"
            case 501...600:
            return"Heavy rain"
            case 601...700:
            return"Snow"
            case 701...771:
            return "Fog"
            case 800:
            return "Sunny"
            case 801 :
            return "Few clouds"
            case 802:
            return "Scattered clouds"
            case 803:
            return "Broken clouds"
            case 804:
            return "Overcast clouds"
            default:
            return "Unknown"
            
        }
    }
    
    func updateWeatherBugConditionName(condition: Int) -> String {
        
        switch (condition) {
            
        case 0...300 :
            return "Thunderstorm"
            
        case 301...500 :
            return "Heavy Showers"
            
        case 501...600 :
            return "Rain"
            
        case 601...700 :
            return "Snow"
            
        case 701...771 :
            return "Fog"
            
        case 772...799 :
            return "Tornado"
            
        case 800 :
            return "Sunny"
            
        case 801 :
            return "Few Clouds"
            
        case 802 :
            return "Scattered Clouds"
            
        case 803 :
            return "Broken Clouds"
            
        case 804 :
            return "Overcast Clouds"
            
        default :
            return "dunno"
        }
    
    }
    
}
