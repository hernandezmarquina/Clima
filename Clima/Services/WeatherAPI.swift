//
//  WeatherApi.swift
//  Clima
//
//  Created by Jonathan Hernandez on 12/10/17.
//  Copyright © 2017 Jonathan Hdez. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class WeatherAPI {
    
    private let BASE_URL = Bundle.main.infoDictionary!["OWM_API_BASE_URL"] as! String
    private let APP_ID = Bundle.main.infoDictionary!["OWM_API_KEY"] as! String
    
    
    /**
         Get weather by geographic coordinates.
     
     - parameter location: geographic coordinates in **OWMLocation** format.
     - parameter onSuccess: A closure to be executed once the request has finished.
     - parameter onFailure: A closure to be executed if the request fails.
     
     - returns : Weather data.
     
     */
    func getWeatherByOWMLocation(location: OWMLocation, onSuccess success: @escaping (_ response : Weather)-> Void, onFailure failure: @escaping (_ error : String) -> Void) {
        
        let latitude = String(location.lat)
        let longitude = String(location.lon)
        
        let request_params : [String: String] = ["lat": latitude, "lon": longitude, "appid": APP_ID]
        
        
        Alamofire.request(BASE_URL, method: .get, parameters : request_params).responseJSON { response in
            
        
            if response.result.isSuccess {
                
                let json : JSON = JSON(response.result.value ?? {})
                
                print("Json response \(json)")
            
                let weatherCondition : Int = json["weather"][0]["id"].intValue
                let weatherTemp : Int = self.convertKelvinToCelsius(kelvin: json["main"]["temp"].doubleValue)
                let name: String = json["name"].stringValue
                
                success(Weather(temperature: weatherTemp, cityName: name, condition : weatherCondition ))
                
            } else {
                failure("Location Unavailable")
            }
            
        }
    }
    
    /**
     Get weather by City name.
     
     - parameter cityName: City name.
     - parameter onSuccess: A closure to be executed once the request has finished.
     - parameter onFailure: A closure to be executed if the request fails.
     
     - returns : Weather data.
     
     */
    func getWeatherByCityName(cityName: String, onSuccess success: @escaping (_ response : Weather)-> Void, onFailure failure: @escaping (_ error : String) -> Void) {
        
        let request_params : [String: String] = ["q": cityName, "appid": APP_ID]
        
        
        Alamofire.request(BASE_URL, method: .get, parameters : request_params).responseJSON { response in
            
            if response.result.isSuccess {
                
                let json : JSON = JSON(response.result.value ?? {})
                
                print("Json response \(json)")
                
                let weatherCondition : Int = json["weather"][0]["id"].intValue
                let weatherTemp : Int = self.convertKelvinToCelsius(kelvin: json["main"]["temp"].doubleValue)
                let name: String = json["name"].stringValue
                
                success(Weather(temperature: weatherTemp, cityName: name, condition : weatherCondition ))
                
            } else {
                failure("Location Unavailable")
            }
            
        }
    }
    
    func convertKelvinToCelsius(kelvin: Double) -> Int {
        return Int(kelvin - 273.15)
    }
}
