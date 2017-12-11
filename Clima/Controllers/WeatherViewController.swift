//
//  ViewController.swift
//  Clima
//
//  Created by Jonathan Hernandez on 12/8/17.
//  Copyright © 2017 Jonathan Hdez. All rights reserved.
//

import UIKit
import CoreLocation
import SVProgressHUD

class WeatherViewControllere: UIViewController, CLLocationManagerDelegate {
    
    
    private var locationManager = CLLocationManager()
    private var weatherApi = WeatherAPI()
    
    @IBOutlet weak var weatherTempLabel: UILabel!
    @IBOutlet weak var weatherIconImage: UIImageView!
    @IBOutlet weak var weatherCityName: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
        let location = OWMLocation(lat:29.087184 , lon: -110.960144)
        
        getWeatherByUserLocation(owmLocation: location)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    /**
         Get weather by geographic coordinates.
     
     - parmeter owmLocation: Current user position in **OWMLocation** format
     
     */
    private func getWeatherByUserLocation(owmLocation: OWMLocation){
        
        SVProgressHUD.show()
        
        weatherApi.getWeatherByOWMLocation(location: owmLocation, onSuccess: {(response) in
            
            SVProgressHUD.dismiss()
            self.updateUIWithWeatherData(weatherData: response)
            
        }) {(error) in
            
            SVProgressHUD.dismiss()
            self.updateUIWithError(error: error)
            
        }
    }
    
    /**
         Update UI with **Weather** data.
     
     - parameter weatherData: new weather data
     
     */
    private func updateUIWithWeatherData(weatherData: Weather){
        weatherCityName.text = weatherData.cityName
        weatherIconImage.image = UIImage(named: weatherData.getWeatherIconName())
        weatherTempLabel.text = "\(weatherData.temperature)º"
    }
    
    private func updateUIWithError(error: String){
        weatherCityName.text = error
        weatherTempLabel.text = "0º"
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        let location = locations[locations.count - 1]
        
        if location.horizontalAccuracy > 0 {
            locationManager.stopUpdatingLocation()
            
            print("latitude \(location.coordinate.latitude) longitude: \(location.coordinate.longitude)")

        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }


}

