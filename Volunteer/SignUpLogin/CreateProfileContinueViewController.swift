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
			print("Updated user")
        } else {
            // There was a problem, check error.description
			self.resetForm(error: error!.localizedDescription)
			}
		}
    }
	
	func resetForm( error:String ) {
		let alert = UIAlertController(title: "Error signing up", message: error, preferredStyle: .alert)
		alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
		self.present(alert, animated: true, completion: nil)
		
		//setContinueButton(enabled: true)
		//continueButton.setTitle("Continue", for: .normal)
	}
    
       
    
}

    

