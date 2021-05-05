//
//  ChangePasswordViewController.swift
//  Volunteer
//
//  Created by Roberto on 4/24/21.
//

import UIKit
import Parse

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var userEmailEntered: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let user = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    

    
    @IBAction func submitForm(_ sender: Any) {
        
        let emailAddressEntered = userEmailEntered.text!
        //let userEmailActual = user.email

        if emailAddressEntered.isEmpty {
            
            let userMessage = "Email Field Cannot Be Empty."
            let myAlert = UIAlertController(title:"Please try again", message:userMessage, preferredStyle: UIAlertController.Style.alert);
                            
            let okAction =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            myAlert.addAction(okAction);
            self.present(myAlert, animated:true, completion:nil);
        }
//        else if  (emailAddressEntered != userEmailActual) {
//            let userMessage = "Email must match the one in your account."
//            let myAlert = UIAlertController(title:"Please try again", message:userMessage, preferredStyle: UIAlertController.Style.alert);
//
//            let okAction =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
//            myAlert.addAction(okAction);
//            self.present(myAlert, animated:true, completion:nil);
//        }
        else{
        
            PFUser.requestPasswordResetForEmail(inBackground: emailAddressEntered, block: { (success:Bool, error:Error?)in
                if(success){
                    
                    let userMessage = "An email with instructions to reset you password has been sent"
                    let myAlert = UIAlertController(title:"Success!", message:userMessage, preferredStyle: UIAlertController.Style.alert);
                    let okAction =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                        
//                    let okAction =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action:UIAlertAction!) -> Void in
//                        DispatchQueue.main.async { self.performSegue(withIdentifier: "returnToSettings", sender: self)}
//                        })
                    myAlert.addAction(okAction);
                    self.present(myAlert, animated:true, completion:nil);
                               
                } else {
                    let userMessage = "There was an error"
                    let myAlert = UIAlertController(title:"Please try again.", message:userMessage, preferredStyle: UIAlertController.Style.alert);
                    let okAction =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                    myAlert.addAction(okAction);
                    self.present(myAlert, animated:true, completion:nil);
                }
            })
        }
    }

}
