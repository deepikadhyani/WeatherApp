//
//  WeatherSearchViewModel.swift
//  WeatherApp
//
//  Created by Deepika Dhyani on 13/02/21.
//  Copyright © 2021 Private. All rights reserved.
//

import Foundation


typealias SuccessAndErrorCompletion = ((Bool, ErrorModel?) -> Void)


class WeatherSearchViewModel {
    
    private var weartherResponse: WeatherResponse?
    private var error: ErrorModel?
    private var searchText = ""
    
    func setSearchText(_ searchText: String) {
        self.searchText = searchText
    }

    // Fetch requested Location
       func fetchSearchData(completionBlock: @escaping SuccessAndErrorCompletion) {
        
        NetworkManager.shareNetworkManager.fetchWeatherForSearchText(searchText: searchText,
                                                                       onCompletion: {
               [weak self] (response, error)  in
                                                                           
               guard let this = self else {
                   completionBlock(false, nil)
                   return
               }
                                                                           
               if let error = error {
                   this.error = error
                   completionBlock(false, error)
                   return
               }
               else {
                   // case of fresh results
                   this.weartherResponse = response
                   completionBlock(true, nil)
                   return
               }
           })
        
    }
    
    func getResponse() -> WeatherResponse? {
        return weartherResponse
    }
    
    func getError()-> ErrorModel?{
        return error
    }
    
    func getUrlForImage() -> String{
        //construct url
        if let icon = weartherResponse?.weather[0].icon{
            return "http://openweathermap.org/img/wn/\(icon)@2x.png"
        }
       return ""
           
    }
    
    //get saved data for favorite city
    func getCitiesData() -> [String]?{
        return Utility.getDataFromDefault(for: Constants.WeatherKeys.FavoriteCities)
    }
    
    // save data to userdefault
    func saveCityToFavorite() -> Bool{
        
        if let citites = getCitiesData(), citites.count > 0{
         // check for duplicate entry
          if citites.contains(searchText)
           {
                 return false
           }
        }
        Utility.saveDataInDefault(value: searchText, key: Constants.WeatherKeys.FavoriteCities)
        return true
    }
}

