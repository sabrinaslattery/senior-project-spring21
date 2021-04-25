//
//  ChangePasswordViewController.swift
//  Volunteer
//
//  Created by Roberto on 4/24/21.
//

import Foundation
import UIKit
import Parse

class ChangePasswordViewController: UIViewController {
    
    @IBOutlet weak var currentPassword: UILabel!
    @IBOutlet weak var newPassword: UILabel!
    @IBOutlet weak var newPasswordConfirm: UILabel!
    @IBOutlet weak var submitButton: UIButton!
    
    let user = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        newPassword.resignFirstResponder()
        newPasswordConfirm.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
    }
    
    @IBAction func submitForm(_ sender: Any) {
        if  (self.newPassword.text != self.newPasswordConfirm.text && self.currentPassword.text != user.password) {
            let userMessage = "Passwords Need to Match."
            let myAlert = UIAlertController(title:"Please Try Again", message:userMessage, preferredStyle: UIAlertController.Style.alert);
                            
            let okAction =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            myAlert.addAction(okAction);
            self.present(myAlert, animated:true, completion:nil);
        }
        else if newPassword.text == "" || newPasswordConfirm.text == "" {
            let userMessage = "Cannot submit null or mismatching fields."
            let myAlert = UIAlertController(title:"Please try again.", message:userMessage, preferredStyle: UIAlertController.Style.alert);
                            
            let okAction =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            myAlert.addAction(okAction);
            self.present(myAlert, animated:true, completion:nil);
        }
        else {
            let query = PFQuery(className: "User")
            query.whereKey("user", equalTo: PFUser.current()!)
            query.getFirstObjectInBackground { [self] (object, error) -> Void in
                if error == nil {
                    let result = object
                    result!["password"] = self.newPassword.text
                    result?.saveInBackground() {
                        (success: Bool, error: Error?) in
                            if (success) {
                                // The object has been saved.
                            let userMessage = "Password Was Successfully Updated."
                            let myAlert = UIAlertController(title:"Success!", message:userMessage, preferredStyle: UIAlertController.Style.alert);
                                
                            let okAction =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action:UIAlertAction!) -> Void in
                                self.performSegue(withIdentifier: "returnToSettings", sender: nil)
                                })
                            myAlert.addAction(okAction);
                            self.present(myAlert, animated:true, completion:nil);
                            }
                            else {
                                let userMessage = "There Was an Error"
                                let myAlert = UIAlertController(title:"Please Try Again.", message:userMessage, preferredStyle: UIAlertController.Style.alert);
                                let okAction =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
                                myAlert.addAction(okAction);
                                self.present(myAlert, animated:true, completion:nil);
                            }
                    }
                }
        }
        }
    }


}
    
