//
//  CreateProfileContinueViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 2/22/21.
//

import Foundation
import UIKit
import Parse

class CreateProfileViewContinueController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var introTextField: UITextField!
    @IBOutlet weak var workExperienceTextField: UITextField!
    @IBOutlet weak var interestsButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
    
    @IBAction func createProfile(_ sender: Any){
        let currentUser = PFUser.current()
        let user = PFObject(className:"Profile")
        // adding objects to the user class
        user ["userBio"] = introTextField.text!
        user ["workExperience"] = workExperienceTextField.text!
        user["user"] = currentUser
        
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
       
    
}

    

