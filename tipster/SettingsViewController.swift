//
//  SettingsViewController.swift
//  tipster
//
//  Created by Emira Hajj on 8/12/20.
//  Copyright © 2020 Emira Hajj. All rights reserved.
//
//  Gear vector icon by: https://www.flaticon.com/authors/freepik
//  Person vector icon by: Emira Hajj

import UIKit

class SettingsViewController: UIViewController {
    
    //Segmented control to sett default tip percentage.
    @IBOutlet weak var defaultTipControl: UISegmentedControl!
    
    //Working with defaults, so USerDefaults must be used.
    let defaults = UserDefaults.standard
    
    //Array that stores the decimal values to represent tip percentages.
    let tipPercentages = [0.15, 0.18, 0.2]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        }
    
    //Makes sure that once the user sets the defaults, goes back to the main view, and naviagates back to settings, that the previous default percentage is highlighted in the segmented controller.
    override func viewWillAppear(_ animated: Bool) {
        let tipPercentage = defaults.double(forKey: "defaultTip")
        
        if (tipPercentage == 0.15){
            defaultTipControl.selectedSegmentIndex = 0
        }
        else if(tipPercentage == 0.18){
            defaultTipControl.selectedSegmentIndex = 1
        }
        else{
            defaultTipControl.selectedSegmentIndex = 2
            
        }
    }

    //Function recieves "Value Changed" event from segmented controller. Sets the default tip percentage using the key "defaultTip"
    @IBAction func defaultChanged(_ sender: Any) {
        
        let defaultTipAmount = tipPercentages[defaultTipControl.selectedSegmentIndex]
        
        if (defaultTipAmount == 0.15){
            defaults.set(defaultTipAmount, forKey: "defaultTip")
        }
        else if (defaultTipAmount == 0.18){
            defaults.set(defaultTipAmount, forKey: "defaultTip")
        }
        else{
            defaults.set(defaultTipAmount, forKey: "defaultTip")
        }
    }
    

}
