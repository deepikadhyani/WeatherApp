//
//  ListOfFavoriteCitiesVC.swift
//  WeatherApp
//
//  Created by Deepika Dhyani on 14/02/21.
//  Copyright © 2021 Private. All rights reserved.
//

import UIKit

protocol ListOfFavoriteCitiesVCDelegate: class {
    func handleSelectedCity(city: String)
}

class ListOfFavoriteCitiesVC: UIViewController {
    
    @IBOutlet weak var citiesTableView: UITableView!
    @IBOutlet weak var labelNoData: UILabel!
    
    weak var delegate: ListOfFavoriteCitiesVCDelegate?
    
    var viewModel: FavoriteCitiesViewModel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        citiesTableView.register(UINib(nibName: Constants.NibName.favoriteCell, bundle: nil), forCellReuseIdentifier:
            Constants.CellIdentifiers.favoriteCellId)
        self.navigationItem.title = Constants.ViewIdentifier.favoriteCities
        setUpInitialView()
    }
    
    func setUpInitialView(){
        if viewModel.getNumberOfRows() > 0{
            labelNoData.isHidden = true
            citiesTableView.isHidden = false
        }else{
            labelNoData.isHidden = false
            citiesTableView.isHidden = true
        }
    }

}


extension ListOfFavoriteCitiesVC: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getNumberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: Constants.CellIdentifiers.favoriteCellId, for: indexPath) as? FavoriteCitiesTableViewCell else {
            return UITableViewCell()
        }
        cell.labelFavoriteCity.text = viewModel.getDataForRow(indexPath: indexPath)
        return cell
    }
}


extension ListOfFavoriteCitiesVC: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.handleSelectedCity(city: viewModel.getDataForRow(indexPath: indexPath))
        self.dismiss(animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         return true
     }

     func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
         if (editingStyle == .delete) {
             // handle delete (by removing the data from your array and updating the tableview)
              viewModel.deleteFavoriteCity(index: indexPath.row)
              tableView.reloadData()
              setUpInitialView()
         }
     }
    
}
