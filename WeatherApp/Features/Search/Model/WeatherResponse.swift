//
//  WeatherResponse.swift
//  WeatherApp
//
//  Created by Deepika Dhyani on 13/02/21.
//  Copyright © 2021 Private. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let description: String?
    let icon: String?
    let id: Int?
    var main: String?
    
   
   
}

struct Main: Codable {
    let feels_like: Double?
    let humidity: Int?
    let temp: Double?
    let temp_max: Double?
    let temp_min: Double?
    
    mutating func getTempInCelcius() -> String?{
        if let _ = temp{
            let tempInCelcius = ((temp ?? 0) - 275.15).rounded(.up)
            return "\(tempInCelcius)" + "°C"
        }
        return ""
    }
}


struct WeatherResponse: Codable {
    var name: String?
    let visibility: Int?
    let weather: [Weather]
    let timezone: Double?
    var main: Main?
}


