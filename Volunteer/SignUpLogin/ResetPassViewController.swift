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
    @IBAction func SendLinkBtnAction(_ sender: Any) {
             let emailAddress = enterEmailTextField.text!

                   if emailAddress.isEmpty
                   {
                       //Display warning message
                       let userMessage: String = "Please type in your email address"
                       displayMessage(userMessage: userMessage)
                       return
                   }

                   PFUser.requestPasswordResetForEmail(inBackground: emailAddress, block: { (success:Bool, error:Error?)in

                       if(success)
                       {
                            //Display success message
                        print("success")
                           
                       } else {
                        //Display error message
                      print(error!.localizedDescription)
                        //CheckEmailViewController()
                       }


                   })
         }

         func displayMessage (userMessage:String)
             {
                     var myAlert = UIAlertController(title: "Missing Email", message: userMessage, preferredStyle: UIAlertController.Style.alert)

                     let okAction = UIAlertAction(title: "OK", style: UIAlertAction.Style.default) {
                         action in
                        // self.dismiss(animated: true, completion: nil)
                     }

                    myAlert.addAction(okAction)
                    self.present(myAlert, animated: true, completion: nil)
                     }


    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}

