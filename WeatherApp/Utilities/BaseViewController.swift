//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Deepika Dhyani on 15/02/21.
//  Copyright © 2021 Private. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var spinner : Spinner?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    // add spinner
    func addSpinner(withTitle spinnerTitle:String = "") -> Void {
        self.removeSpinner()
        self.spinner = Spinner(title: spinnerTitle, view: self.view)
        self.spinner?.showHud()
    }
    
    // remove spinner
    func removeSpinner() -> Void {
        self.spinner?.removeHUD()
        self.spinner = nil
    }
    
}
