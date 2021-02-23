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
    @IBOutlet weak var skillsButton: UIButton!
    @IBOutlet weak var interestsButton: UIButton!
    @IBOutlet weak var continueToPrivacyButton: UIButton!
    
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
    
}
