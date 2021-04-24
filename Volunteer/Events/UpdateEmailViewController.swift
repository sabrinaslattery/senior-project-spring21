//
//  UpdateEmailViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 4/23/21.
//

import UIKit
import Parse

class UpdateEmailViewController: UIViewController {
    
    @IBOutlet weak var currentEmail: UILabel!
    @IBOutlet weak var newEmail: UITextField!
    @IBOutlet weak var confirmNewEmail: UITextField!
    @IBOutlet weak var submitButton: UIButton!
    
    let user = PFUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userEmail()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        newEmail.resignFirstResponder()
        confirmNewEmail.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
    }
    
    func userEmail(){
        let userEmail = PFUser.current()?.object(forKey: "email") as! String
        self.currentEmail?.text = userEmail
        print(userEmail)
    }
    
    @IBAction func submitForm(_ sender: Any) {
        if  (self.newEmail.text != self.confirmNewEmail.text) {
            let userMessage = "Emails must match."
            let myAlert = UIAlertController(title:"Please try again", message:userMessage, preferredStyle: UIAlertController.Style.alert);
                            
            let okAction =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default)
            myAlert.addAction(okAction);
            self.present(myAlert, animated:true, completion:nil);
        }
        else if !newEmail.hasText || !confirmNewEmail.hasText {
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
                    result!["email"] = self.newEmail.text
                    result?.saveInBackground() {
                        (success: Bool, error: Error?) in
                            if (success) {
                                // The object has been saved.
                            let userMessage = "Email successfully updated."
                            let myAlert = UIAlertController(title:"Success!", message:userMessage, preferredStyle: UIAlertController.Style.alert);
                                
                            let okAction =  UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: { (action:UIAlertAction!) -> Void in
                                self.performSegue(withIdentifier: "returnToSettings", sender: nil)
                                })
                            myAlert.addAction(okAction);
                            self.present(myAlert, animated:true, completion:nil);
                            }
                            else {
                                let userMessage = "There was an error"
                                let myAlert = UIAlertController(title:"Please try again.", message:userMessage, preferredStyle: UIAlertController.Style.alert);
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
