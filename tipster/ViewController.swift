//
//  ViewController.swift
//  tipster
//
//  Created by Emira Hajj on 8/10/20.
//  Copyright © 2020 Emira Hajj. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    //initialize all the outlets from our storyboard
    //label for total tip amount
    @IBOutlet weak var tipLabel: UILabel!
    
    //label for total bill amount (including tip)
    @IBOutlet weak var totalLabel: UILabel!
    
    //segmented control to vary tip amount
    @IBOutlet weak var tipControl: UISegmentedControl!
    
    //text field to input the bill amount before tip
    @IBOutlet weak var billField: UITextField!
    
    //tip splitting labels for tip amount when splitting between two, three, and four people, respectively.
    @IBOutlet weak var TwoPeople: UILabel!
    @IBOutlet weak var ThreePeople: UILabel!
    @IBOutlet weak var FourPeople: UILabel!
    
    //navbar outlet--settings button will live here
    @IBOutlet weak var navbar: UINavigationItem!
    
    //UIView for the bottom portion of the app to be animated into view
    @IBOutlet weak var bottomView: UIView!
    
    //boolean flag used in func changingText
    var onlyOnce = false
    
    //We hav a Settings menu that ask the user for defaults, so we must make use of UserDefaults.
    let defaults = UserDefaults.standard

    //base function
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Keyboard should automatically open, field to be ready for immediate population
        billField.becomeFirstResponder()
    }
    
    
    //Function that fades in the bottom portion of the app as you start filling in the bill field.
    @IBAction func changingText(_ sender: Any) {
        
        //The bill field sends an "editing changed action" to this function, but I don't want this translation animation resettiong from the bottom everytime a new character is input--so I used a boolean flag that effectively only triggers this animation on the first keystroke when the field is empty.
        
        if (self.onlyOnce == false){
            UIView.animate(withDuration: 0.7, animations: {
                self.bottomView.alpha = 1
                self.bottomView.frame.origin.y -= 150
            })
            UITextView.animate(withDuration: 0.7, animations: {
                self.billField.transform = self.billField.transform.translatedBy(x: 0, y: -150)
            })
            self.onlyOnce = true
        }
        
        //Returns the views to their original state when the billField is emptied by the user using backspaces. Sets the boolean to false so the animation can start again on new input.
        if (billField.text == ""){
            UIView.animate(withDuration: 0.7, animations: {
                self.bottomView.alpha = 0
                self.bottomView.frame.origin.y += 150
            })
            UITextView.animate(withDuration: 0.7, animations: {
                self.billField.transform = self.billField.transform.translatedBy(x: 0, y: +150)
            })
            self.onlyOnce = false
        }

    }
    
    //Whenever the main view loads (either from start-up or from navigating back from the settings), the tip percentage should always be set to whatever the user sets as the default. On startup, the selected segment is always 15%.
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let bill =  Double(billField.text!) ?? 0
        
        //calculate the tip and total
        let tipPercentage = defaults.double(forKey: "defaultTip")
        
        //Set the selected tip percentage in the main view's segmented controller to reflect the users default upon redirection from the settings view.
        if (tipPercentage == 0.15){
            tipControl.selectedSegmentIndex = 0
        }
        else if(tipPercentage == 0.18){
            tipControl.selectedSegmentIndex = 1
        }
        else{
            tipControl.selectedSegmentIndex = 2

        }
        
        //Calculate the tip amount and total bill
        let tip = bill * tipPercentage
        let total = bill + tip

        //update the tip and total labels, with proper formatting
        tipLabel.text = "$" + String(format: "%.2f", tip)
        totalLabel.text = "$" + String(format: "%.2f", total)
        TwoPeople.text = "$" + String(format: "%.2f", tip/2)
        ThreePeople.text = "$" + String(format: "%.2f", tip/3)
        FourPeople.text = "$" + String(format: "%.2f", tip/4)
        
    }
    
    //Function to execute when user taps on the screen--used to dismiss keyboard
    @IBAction func onTap(_ sender: Any) {
        view.endEditing(true)
    }
    
    //function to get bill amount, calculate tip and total and update the amounts on the screen
    @IBAction func calculateTip(_ sender: Any) {
        
        //Get bill amount
        //Bill amount will be 0 if input isn't numeric
        let bill =  Double(billField.text!) ?? 0
        
        //calculate the tip and total
        let tipPercentages = [0.15, 0.18, 0.2]
        let tip = bill * tipPercentages[tipControl.selectedSegmentIndex]
        let total = bill + tip
        
        //update the tip and total labels, with proper formatting
        tipLabel.text = "$" + String(format: "%.2f", tip)
        totalLabel.text = "$" + String(format: "%.2f", total)
        TwoPeople.text = "$" + String(format: "%.2f", tip/2)
        ThreePeople.text = "$" + String(format: "%.2f", tip/3)
        FourPeople.text = "$" + String(format: "%.2f", tip/4)
    }
}
