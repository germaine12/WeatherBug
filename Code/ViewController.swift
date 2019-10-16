//
//  ViewController.swift
//  WeatherBug
//
//  Created by Germaine Uwimpuhwe on 4/28/19.
//  Copyright © 2019 Germaine Uwimpuhwe. All rights reserved.
//

import UIKit
import CoreLocation // Core Location provides services for determining a device’s       geographic location, altitude, orientation, or position relative to a nearby iBeacon.
import SwiftyJSON// SwiftyJSON makes it easy to deal with JSON data in Swift.
import Alamofire// Alamofire is an HTTP networking library written in Swift.

class ViewController: UIViewController, CLLocationManagerDelegate { // Protocal CLLocationManagerDelegate The methods that you use to receive events from an associated location manager object.
    
    @IBOutlet weak var cityName: UILabel!
    @IBOutlet weak var condition: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var minTemp: UILabel!
    @IBOutlet weak var maxTemp: UILabel!
    
    
    @IBOutlet weak var mySwitch: UISwitch!
    
    
    @IBAction func `switch`(_ sender: UISwitch) { // It allows to switch on and off the weather data requests.
        if sender.isOn{
            
        }
    }
    // API constants: URL,AppID
    let weatherBugURL = "http://api.openweathermap.org/data/2.5/weather"
    let appID = "Your provided Key from API" // my key
    
    
    // Declaring instance variables
    let locationManager = CLLocationManager()
    let weatherBugCondition =  WeatherBugCondition()
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // LocationManager set up
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationaMnager.startUpdatingLocation()
    }
    // functions
    func fetchWeatherJSONData(url: String, parameters:[String: String]){
        Alamofire.request(url,method:.get, parameters: parameters).responseJSON{
            response in
            if response.result.isSuccess{
                print("API Weather Data")
                let dataJSON : JSON = JSON(response.result.value!)
                
                print(dataJSON)
                self.updateDataJSON(json:dataJSON)
                
            }
            else{
                print("Error\(String(describing:response.result.error))")
                self.cityName.text = "Connection Issues"
            }
        }
      
    }
    // Parsing JSON file
    func updateDataJSON(json: JSON){
        let tempValue = json["main"]["temp"].doubleValue
        let tempMinValue = json["main"]["temp_min"].doubleValue
        let tempMaxValue = json["main"]["temp_max"].doubleValue
        weatherBugCondition.temperature = Int((tempValue - 273.15) * 0)
        weatherBugCondition.city = json["name"].stringValue
        weatherBugCondition.condition = json["weather"][0]["id"].intValue
        weatherBugCondition.minTemp = Int(tempValue - 273.15)
        weatherBugCondition.maxTemp = Int(tempValue - 273.15)
        weatherBugCondition.weatherImageName = weatherBugCondition.updateWeatherBugCondition(condition:weatherBugCondition.condition)
        weatherBugCondition.weatherCondition = weatherBugCondition.updateWeatherBugConditionName(condition: weatherBugCondition.condition)
        updateUIWithWeatherData()


    }
    
   func updateUIWithWeatherData()
   {
    cityName.text = weatherBugCondition.city
    temp.text = "\(weatherBugCondition.temperature)°"
    weatherImage.image = UIImage(named: weatherBugCondition.weatherImageName)
    minTemp.text = "\(weatherBugCondition.minTemp)°"
    maxTemp.text = "\(weatherBugCondition.maxTemp)°"
    condition.text = weatherBugCondition.weatherCondition
    }
    
    // write the didUpdateLocations method
    func locationManager(_manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        let location = locations[locations.count - 1]
        if location.horizontalAccuracy > 0{
            self.locationManager.stopUpdatingLocation()
            print("longitude = \(location.coordinate.longitude),latitude = \(location.coordinate.latitude)")
            let latitude = String(location.coordinate.latitude)
            let longitude = String(location.coordinate.longitude)
            
            let params : [String : String] = ["lat" : latitude, "lon" : longitude, "appid" : appID]
            
            fetchWeatherJSONData(url: weatherBugURL, parameters: params)
        }
    }
    
    func locationManager(_manager:CLLocationManager, didFailWithError error: Error){
    print(error)
    cityName.text = "Location Unavailable"
    }
  
}

