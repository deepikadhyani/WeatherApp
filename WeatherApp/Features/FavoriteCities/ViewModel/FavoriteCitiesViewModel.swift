//
//  FavoriteCitiesViewModel.swift
//  WeatherApp
//
//  Created by Deepika Dhyani on 14/02/21.
//  Copyright © 2021 Private. All rights reserved.
//

import Foundation

class FavoriteCitiesViewModel {
    
    private var citiesArr = [String]()
    
    init() {
        initialiseData()
    }
    
    func initialiseData(){
        citiesArr = Utility.getDataFromDefault(for: Constants.WeatherKeys.FavoriteCities)
    }
    
    func getDataForRow(indexPath : IndexPath) -> String{
        return citiesArr[indexPath.row]
    }
    
    func getNumberOfRows() -> Int {
        return citiesArr.count
    }
    
    func deleteFavoriteCity(index: Int){
        var array = Utility.getDataFromDefault(for: Constants.WeatherKeys.FavoriteCities)
        array.remove(at: index)
        Utility.saveArrayInDefault(value: array, key: Constants.WeatherKeys.FavoriteCities)
        citiesArr.remove(at: index)
    }
    
}
