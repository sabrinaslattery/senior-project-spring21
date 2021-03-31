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
    @IBOutlet weak var continueToPrivacyButton: UIButton!
    
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
    
    @IBAction func createProfile(_ sender: Any){
        let user = PFObject(className:"Profile")
        
        // adding objects to the user class
        user ["userBio"] = introTextField.text!
        user ["workExperience"] = workExperienceTextField.text!
        
        user.saveInBackground {
        (success: Bool, error: Error?) in
        if (success) {
            // The object has been saved.
        } else {
            // There was a problem, check error.description
        }
    }
    }
    
       
    
}

    

