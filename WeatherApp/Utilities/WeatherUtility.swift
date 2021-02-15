//
//  WeatherUtility.swift
//  WeatherApp
//
//  Created by Deepika Dhyani on 14/02/21.
//  Copyright © 2021 Private. All rights reserved.
//

import Foundation

class Utility {
    
   class func saveDataInDefault(value: String, key: String){
        let userDefaults = UserDefaults.standard
        // Read/Get Array of Strings
        var strings: [String] = userDefaults.stringArray(forKey: key) ?? []

        // Append String to Array of Strings
        strings.append(value)
        userDefaults.set(strings, forKey: key)
        userDefaults.synchronize()
    }
    
   class func getDataFromDefault(for key: String) -> [String]{
        // Access Shared Defaults Object
        let userDefaults = UserDefaults.standard

        // Read/Get Array of Strings
        let strings: [String] = userDefaults.object(forKey: key) as? [String] ?? []
        return strings
    }
    
    class func saveArrayInDefault(value: [String], key: String){
        let userDefaults = UserDefaults.standard
        userDefaults.set(value, forKey: key)
        userDefaults.synchronize()
    }
    
    
    class func getCurrentTime(timeStamp : Double) -> String{
        let date = Date(timeIntervalSince1970: (timeStamp/1000))
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_IN")
        dateFormatter.dateFormat = "HH:mm"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 3600)

        let localDate = dateFormatter.string(from: date)
        return localDate
    }
    
    
    
}
