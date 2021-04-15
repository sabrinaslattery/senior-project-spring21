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
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
    
    @IBAction func handlePopView(_ sender: Any) {
        presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func SendLinkBtnAction(_ sender: Any) {
        let emailAddress = enterEmailTextField.text!

        if emailAddress.isEmpty {
        //Display warning message
            let missingEmailMessage: String = "Please type in your email address"
            displayMissingEmailMessage(missingEmailMessage: missingEmailMessage)
            return
        }
        PFUser.requestPasswordResetForEmail(inBackground: emailAddress, block: { (success:Bool, error:Error?)in
            if(success){
            //Display success message
                let emailSentMessage: String = "We have emailed your password reset link to "  + emailAddress
                self.displayEmailSentMessage(emailSentMessage: emailSentMessage)
                print("success")
                           
            } else {
            //Display error message
                print(error!.localizedDescription)
                //CheckEmailViewController()
            }
        })
    }
    
    func displayMissingEmailMessage (missingEmailMessage:String) {
            let myAlert = UIAlertController(title: "Missing Email", message: missingEmailMessage, preferredStyle: UIAlertController.Style.alert)
            let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) { action in
                // self.dismiss(animated: true, completion: nil)
            }
            myAlert.addAction(okAction)
            self.present(myAlert, animated: true, completion: nil)
    }

    func displayEmailSentMessage (emailSentMessage:String){
        let myAlert = UIAlertController(title: "Check your Email!", message: emailSentMessage, preferredStyle: UIAlertController.Style.alert)

        let okAction = UIAlertAction(title: "Return to Login", style: UIAlertAction.Style.default) {
                            action in
            // self.dismiss(animated: true, completion: nil)
            self.performSegue(withIdentifier: "showLoginView", sender: nil)
        }

        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
}

