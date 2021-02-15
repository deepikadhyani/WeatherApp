//
//  Constants.swift
//  WeatherApp
//
//  Created by Deepika Dhyani on 13/02/21.
//  Copyright © 2021 Private. All rights reserved.
//

import Foundation


struct Constants {

   struct OpenWeatherURLParams {
        static let APIScheme = "https"
        static let APIHost = "api.openweathermap.org"
        static let APIPath = "/data/2.5/weather"
        static let ImagePath = "/img/wn/"
    }
    
   struct OpenWeatherAPIKeys {
          static let Text = "q"
          static let APIKey = "appid"
          static let ImageExtention = "@2x.png"
    }
    
    struct OpenWeatherAPIValues {
        static let APIKey = "4772be0c49e899b2b4568512e51566b4"
    }
    
    struct Errors {
        static let notFoundErrorCode = "404"
        static let alertTitle = "Oops!"
        static let alertSuccessTitle = "Yeeepiiii!"
        static let duplicateEntryMessage = "Already in your favorite list."
        static let moreCharacterMessage = "Search should have atleast 3 character."
        static let markedAsFavorite = "Marked as favorite."
        static let doneButtonText = "Ok"
        static let cityNotFoundError = "City not found."
        static let unknownError = "Unkown error occured."
    }

    struct WeatherKeys {
        static let FavoriteCities = "favoriteCities"
    }
    
    struct NibName {
        static let favoriteCell = "FavoriteCitiesTableViewCell"
        static let storyBoard = "Main"
        static let favoriteCitiesVC = "ListOfFavoriteCitiesVC"
    }
   
    struct CellIdentifiers {
        static let favoriteCellId = "FavoriteCitiesTableViewCell"
    }
    
    struct ViewIdentifier{
        static let searchWeatherTitle = "Current Weather"
        static let favoriteCities = "Favorite Cities"
    }
    
    struct WeatherResultText {
        static let currentWeather = "Current weather in "
    }
}

