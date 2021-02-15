//
//  NetworkManager.swift
//  WeatherApp
//
//  Created by Deepika Dhyani on 13/02/21.
//  Copyright © 2021 Private. All rights reserved.
//

import Foundation
public enum EHttpStatusCode : Int {
    case OK = 200                       // /GET, /DELETE result is successful
    case CREATED = 201                  // /POST or /PUT is successful
    case NOT_MODIFIED = 304             // If caching is enabled and etag matches with the server
    case BAD_REQUEST = 400              // Possibly the parameters are invalid
    case INVALID_CREDENTIAL = 401       // INVALID CREDENTIAL, possible invalid token
    case NOT_FOUND = 404                // The item you looked for is not found
    case CONFLICT = 409                 // Conflict - means already exist
    case AUTHENTICATION_EXPIRED = 419   // Expired
    case INVALID_RESPONSE = 1234
    case CUSTOM_ERROR = 418         // I'm a teapot
    case UNSUPPORT_MEDIA = 415
    case Internal_Server_Error = 500
}

class NetworkManager : NSObject {

 private override init() {}
 static let shareNetworkManager = NetworkManager()
    
    
    //construct url
       private func openWeatherURLFromParameters(searchString: String,
                                            page: Int = 1) -> URL {
           
           let escapedSearchText = searchString.addingPercentEncoding(withAllowedCharacters:.urlHostAllowed)!
           // Build base URL
           var components = URLComponents()
           components.scheme = Constants.OpenWeatherURLParams.APIScheme
           components.host = Constants.OpenWeatherURLParams.APIHost
           components.path = Constants.OpenWeatherURLParams.APIPath
           
           // Build query string
           components.queryItems = [URLQueryItem]()
           
           // Query components
          components.queryItems?.append(URLQueryItem(name: Constants.OpenWeatherAPIKeys.Text, value: escapedSearchText));
           components.queryItems?.append(URLQueryItem(name: Constants.OpenWeatherAPIKeys.APIKey, value: Constants.OpenWeatherAPIValues.APIKey));
           return components.url!
       }
    
    

// fetch weather against search text
   func fetchWeatherForSearchText(searchText: String,
                                 onCompletion: @escaping (_ response: WeatherResponse?,
                                                          _ error: ErrorModel? ) -> Void ) -> Void {
        let url = openWeatherURLFromParameters(searchString: searchText)
    
        self.connectToServer(searchText: url) { (responseObj, err, status) in
            if status == true{
                guard let weatherResponseContainer = responseObj as! NSDictionary? else { return }
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: weatherResponseContainer, options: [])
                let decoder = JSONDecoder()
                let weatherResponseContainer = try decoder.decode(WeatherResponse.self, from: jsonData)
                onCompletion(weatherResponseContainer, nil)
            }
            catch {
                onCompletion(nil, err )
                return
            }
            }else{
                onCompletion(nil, err)
            }
        }
    }


func connectToServer(searchText: URL,
                     onCompletion: @escaping (_ response: AnyObject?,
    _ error: ErrorModel?, _ status: Bool ) -> Void ) -> Void {
    let searchTask = URLSession.shared.dataTask(with: searchText as URL, completionHandler: {data, response, error -> Void in

        if let error = error {
            let error = ErrorModel(errMsg: error.localizedDescription, errStatus: "")
            onCompletion(nil, error, false)
            return
        }
        do {
               let resultsDictionary = try JSONSerialization.jsonObject(with: data!, options: []) as? [String: AnyObject]
               guard let results = resultsDictionary else { return }
            
        let httpResponse = response as! HTTPURLResponse
        
           switch httpResponse.statusCode{
           case EHttpStatusCode.OK.rawValue:
            onCompletion(results as AnyObject?,nil , true)
            
           case EHttpStatusCode.CREATED.rawValue:
                onCompletion(results as AnyObject?,nil ,true)
           case EHttpStatusCode.NOT_FOUND.rawValue:
            let error = ErrorModel(errMsg: Constants.Errors.cityNotFoundError, errStatus: "\(httpResponse.statusCode)")
               onCompletion(nil, error,false)
            default:
                let error = ErrorModel(errMsg: Constants.Errors.unknownError, errStatus:"\(EHttpStatusCode.CUSTOM_ERROR.rawValue)" )
                    onCompletion(nil, error, false)
                    
                }
        }
        catch {
            
        }
    })
         searchTask.resume()
  }

}
