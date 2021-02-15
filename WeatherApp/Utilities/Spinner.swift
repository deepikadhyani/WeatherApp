//
//  Spinner.swift
//  WeatherApp
//
//  Created by Deepika Dhyani on 15/02/21.
//  Copyright © 2021 Private. All rights reserved.
//

import Foundation
import MBProgressHUD

struct Spinner {
    
    var spinnerTitle:String?
    var spinnerView:UIView?
    var spinner:MBProgressHUD?
    
    // init will initialize all the variables
    init(title:String, view:UIView?){
        
        self.spinnerTitle = title
        self.spinnerView = view
    }
    
    // will present the HUD/Spinner on initialized view, otherwise not
    mutating func showHud() {
        self.spinner = MBProgressHUD.showAdded(to: self.spinnerView!, animated: true)
        if spinnerTitle != nil {
            self.spinner?.label.text = self.spinnerTitle!
        }
    }
    
    // will hide the HUD/Spinner and create all its objects nil
    mutating func removeHUD() {
        
        hideHUD()
        self.spinnerTitle = nil
        self.spinner = nil
        self.spinnerView = nil
    }
    
    // hiding HUD here
    func hideHUD(){
        
        if let animatorView = self.spinnerView{
            
            MBProgressHUD.hide(for: animatorView, animated: true)
        }
        
    }
    
}
