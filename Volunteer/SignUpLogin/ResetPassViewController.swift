//
//  ResetPassViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 2/22/21.
//

import Foundation
import UIKit
import Parse

class ResetPassViewController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var enterEmailTextField: UITextField!
    @IBOutlet weak var sendInstructionButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
    
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}

