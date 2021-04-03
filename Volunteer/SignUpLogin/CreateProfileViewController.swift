//
//  CreateProfileViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 2/22/21.
//

import Foundation
import UIKit
import Parse

class CreateProfileViewController:UIViewController, UITextFieldDelegate {
    
   
   
    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var educationLevelTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    

    
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
      
    }
    
    @IBAction func createProfile(_ sender: Any){
        let user = PFObject(className:"Profile")
        user ["jobTitle"] = jobTitleTextField.text!
        user ["city"] = cityTextField.text!
        user["zipCode"] = zipCodeTextField.text!
        user["educationLevel"] = educationLevelTextField.text!
    
        user.saveInBackground {
            (success: Bool, error: Error?) in
            if (success) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
    }
    
    
    func setContinueButton(enabled:Bool) {
        if enabled {
            continueButton.alpha = 1.0
            continueButton.isEnabled = true
        } else {
            continueButton.alpha = 0.5
            continueButton.isEnabled = false
        }
    }
    
    
    func resetForm() {
        let alert = UIAlertController(title: "Error signing up", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        setContinueButton(enabled: true)
        continueButton.setTitle("Continue", for: .normal)
    }
}




    

