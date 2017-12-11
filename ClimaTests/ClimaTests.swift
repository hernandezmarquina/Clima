//
//  ClimaTests.swift
//  ClimaTests
//
//  Created by Jonathan Hernandez on 12/8/17.
//  Copyright © 2017 Jonathan Hdez. All rights reserved.
//

import XCTest
@testable import Clima

class ClimaTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testKelvinToCelsiusConversion() {
        let weatherApi = WeatherAPI()
        
        let kelvinValueToTest : Double = 300
        
        let correctCelciusValueExpression: Int = 26
        
        XCTAssertEqual(weatherApi.convertKelvinToCelsius(kelvin: kelvinValueToTest), correctCelciusValueExpression)
        
    }
    
    func testWeatherIconName(){
        
        var weather = Weather(temperature: 27, cityName: "Test City", condition: 1000)
        
        XCTAssertEqual(weather.getWeatherIconName(), "tstorm3")
        
        weather.condition = 500
        
        XCTAssertEqual(weather.getWeatherIconName(), "light_rain")
        
        weather.condition = 720
        
        XCTAssertEqual(weather.getWeatherIconName(), "fog")
        
    }
    
    func 
    
}
