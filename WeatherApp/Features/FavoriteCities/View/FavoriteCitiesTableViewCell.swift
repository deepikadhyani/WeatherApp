//
//  FavoriteCitiesTableViewCell.swift
//  WeatherApp
//
//  Created by Deepika Dhyani on 14/02/21.
//  Copyright © 2021 Private. All rights reserved.
//

import UIKit

class FavoriteCitiesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var labelFavoriteCity: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
}
