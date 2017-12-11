//
//  ChangeCityViewController.swift
//  Clima
//
//  Created by Jonathan Hernandez on 12/11/17.
//  Copyright © 2017 Jonathan Hdez. All rights reserved.
//

import Foundation
import UIKit

protocol ChangeCityViewDelegate {
    func userEnteredANewCityName(_ cityName: String)
}

class ChangeCityViewController: UIViewController {
    
    
    var delegate : ChangeCityViewDelegate?
    
    @IBOutlet weak var cityTextField: UITextField!
    
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func BackButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func getWeatherButtonPressed(_ sender: UIButton) {
        
        if let cityName = cityTextField.text {
            
            delegate?.userEnteredANewCityName(cityName)
            self.dismiss(animated: true, completion: nil)
        }
        
    }
}
