//
//  VerifyEmailViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 2/22/21.
//

import Parse
import Foundation
import UIKit

class VerifyEmailViewController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var enterCodeTextField: UITextField!
    @IBOutlet weak var enterButton: UIButton!
    @IBOutlet weak var resendCodeButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
	@IBAction func onEnter(_ sender: Any) {
		PFUser.logOutInBackground()
		performSegue(withIdentifier: "BackToLogin", sender: self)
	}
	
	@IBAction func resendCode(_ sender: Any) {
		
	}
	@IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
}
