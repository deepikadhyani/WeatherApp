//
//  WeatherSearchViewController.swift
//  WeatherApp
//
//  Created by Deepika Dhyani on 13/02/21.
//  Copyright © 2021 Private. All rights reserved.
//

import UIKit
import SDWebImage

class WeatherSearchViewController: BaseViewController {
    
    @IBOutlet weak var lableCityName: UILabel!
    @IBOutlet weak var imageCurrentWeather: UIImageView!
    @IBOutlet weak var labelTemprature: UILabel!
    @IBOutlet weak var labelHumidity: UILabel!
    @IBOutlet weak var labelDescription: UILabel!
    @IBOutlet weak var buttonMarkFav: UIButton!
    @IBOutlet weak var buttonFavCities: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var labelEmptyScreen: UILabel!
    @IBOutlet weak var viewBackground: UIView!
    @IBOutlet weak var labelCurrentTime: UILabel!
    
    
    private lazy var viewModel = WeatherSearchViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        buttonMarkFav.isEnabled = false
        self.navigationItem.title = Constants.ViewIdentifier.searchWeatherTitle
    }
    
    
    private func fetchSearchData() {
           addSpinner()
           viewModel.fetchSearchData(completionBlock: { [weak self] (success, error) in
               
               guard let this = self else {
                   return
               }
             DispatchQueue.main.async {
                   this.removeSpinner()
                   if let _ = error {
                       // Show error in popup
                    this.buttonMarkFav.isEnabled = false
                    this.viewBackground.isHidden = true
                    this.showErrorAlertForSearchResult()
                    this.labelEmptyScreen.isHidden = false
                    return
                   }
                  //update data here
                   this.setUpData()
                   this.labelEmptyScreen.isHidden = true
                   this.viewBackground.isHidden = false
                   this.buttonMarkFav.isEnabled = true
               }
           })
    }
    
    func setUpData(){
        viewBackground.isHidden = false
        labelEmptyScreen.isHidden = true
        if var model = viewModel.getResponse(){
            lableCityName.text = Constants.WeatherResultText.currentWeather + (model.name ?? "")
            labelHumidity.text = "Humidity:  " + "\(model.main?.humidity ?? 0)" + "%"
            labelTemprature.text =  (model.main?.getTempInCelcius() ?? "0")
            labelDescription.text = model.weather[0].description
            imageCurrentWeather.sd_setImage(with: URL(string: viewModel.getUrlForImage()))
            let currentTime = Utility.getCurrentTime(timeStamp: model.timezone ?? 0)
            labelCurrentTime.text = "As of" + currentTime + "IST"
        }
    }
    
    @IBAction func markAsFavorite(_ sender: UIButton){
        if !viewModel.saveCityToFavorite(){
            showAlertForDuplicateEntry()
        }else{
            showAlertForMarkedAsFavorite()
        }
    }
    
    @IBAction func getListOfFavoriteCity(_ sender: UIButton){
        let sb = UIStoryboard(name: Constants.NibName.storyBoard, bundle: nil)
        if let vc = sb.instantiateViewController(identifier: Constants.NibName.favoriteCitiesVC) as? ListOfFavoriteCitiesVC{
            vc.delegate = self
            vc.viewModel = FavoriteCitiesViewModel.init()
            navigationController?.present(vc, animated: true, completion: nil)
        }
    }
    
    func showAlertForDuplicateEntry(){
        let alert = UIAlertController(title: Constants.Errors.alertTitle, message: Constants.Errors.duplicateEntryMessage, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: Constants.Errors.doneButtonText, style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertForMoreCharacters(){
           let alert = UIAlertController(title: Constants.Errors.alertTitle, message: Constants.Errors.moreCharacterMessage, preferredStyle: UIAlertController.Style.alert)
           alert.addAction(UIAlertAction(title: Constants.Errors.doneButtonText, style: UIAlertAction.Style.default, handler: nil))
           self.present(alert, animated: true, completion: nil)
    }
    
    func showAlertForMarkedAsFavorite(){
              let alert = UIAlertController(title: Constants.Errors.alertSuccessTitle, message: Constants.Errors.markedAsFavorite, preferredStyle: UIAlertController.Style.alert)
              alert.addAction(UIAlertAction(title: Constants.Errors.doneButtonText, style: UIAlertAction.Style.default, handler: nil))
              self.present(alert, animated: true, completion: nil)
       }
    
    func showErrorAlertForSearchResult(){
        let errorModel = viewModel.getError()
        let alert = UIAlertController(title: Constants.Errors.alertTitle, message: errorModel?.errMsg, preferredStyle: UIAlertController.Style.alert)
          alert.addAction(UIAlertAction(title: Constants.Errors.doneButtonText, style: UIAlertAction.Style.default, handler: nil))
          self.present(alert, animated: true, completion: nil)
    }
    
}


extension WeatherSearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if searchBar.text?.count ?? 0 > 2{
            getDataForSearchedString()
        }else{
            showAlertForMoreCharacters()
        }
    }
    
    func getDataForSearchedString(){
        if let searchText = searchBar.text,
               searchText.count > 0 {
               searchBar.resignFirstResponder()
               // call network api
               viewModel.setSearchText(searchText)
               fetchSearchData()
        }
    }
    
}

extension WeatherSearchViewController: ListOfFavoriteCitiesVCDelegate{
    func handleSelectedCity(city: String) {
         searchBar.text = city
         getDataForSearchedString()
    }
    
    
}
