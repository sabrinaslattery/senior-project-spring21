//
//  SignUpViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 2/21/21.
//

import Foundation
import UIKit
import Parse
import AlamofireImage

class SignUpViewController:UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var phonenumberField: UITextField!
    //@IBOutlet weak var profileImageView: UIImageView!
    //@IBOutlet weak var tapToChangeProfileButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
 
    
    //var continueButton:RoundedWhiteButton!
    var activityView:UIActivityIndicatorView!
    
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)

        
        firstnameField.delegate = self
        lastnameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        firstnameField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        lastnameField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
		
		
    }
    
    // Storing username and password in the database 
    @IBAction func signUp(_ sender: Any){
        let user = PFUser()
        user.username = emailField.text!
        user.password = passwordField.text!
		user.email = emailField.text!
        
        // customizing password rules
       
       
        
        // adding objects to the user class

        user["firstname"] = firstnameField.text!
        user["lastname"] = lastnameField.text!
		//user["newUser"] = true
        
       
        
		if !firstnameField.hasText || !lastnameField.hasText || !emailField.hasText || !passwordField.hasText {
			let alert = UIAlertController(title: "Oops!", message: "Please fill out all of the required information", preferredStyle: .alert)
			alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
				
			}))
			self.present(alert, animated: true)
			print("Error:")
		} else {
			user.signUpInBackground { (success, error) in
				if success{
					self.performSegue(withIdentifier: "ToSetupProfile", sender: nil)
				} else {
				let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
					print(error.debugDescription)
				}))
				self.present(alert, animated: true)
				print("Error: \(String(describing: error.debugDescription))")
			 }
		}
		}
}
    

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        firstnameField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        firstnameField.resignFirstResponder()
        lastnameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    @objc func keyboardWillAppear(notification: NSNotification){
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
//        continueButton.center = CGPoint(x: view.center.x,
//                                        y: view.frame.height - keyboardFrame.height - 16.0 - continueButton.frame.height / 2)
//        activityView.center = continueButton.center
    }
    
    
    @objc func textFieldChanged(_ target:UITextField) {
        let firstName = firstnameField.text
        let lastName = lastnameField.text
        let email = emailField.text
        let password = passwordField.text
        let formFilled = firstName != nil && firstName != "" && lastName != nil && lastName != "" && email != nil && email != "" && password != nil && password != ""
        setContinueButton(enabled: formFilled)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case firstnameField:
            firstnameField.resignFirstResponder()
            lastnameField.becomeFirstResponder()
            break
        case lastnameField:
            lastnameField.resignFirstResponder()
            emailField.becomeFirstResponder()
        case emailField:
            emailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
            break
        case passwordField:
            //handleSignUp()
            break
        default:
            break
        }
        return true
    }
    
    func setContinueButton(enabled:Bool) {
        if enabled {
            continueButton.alpha = 1.0
            continueButton.isEnabled = true
        } else {
            continueButton.alpha = 0.5
            continueButton.isEnabled = false
        }
    }
    
    
   
    
    
    
    
    func resetForm() {
        let alert = UIAlertController(title: "Error signing up", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        setContinueButton(enabled: true)
        continueButton.setTitle("Continue", for: .normal)
        activityView.stopAnimating()
    }
    
    
   
}
