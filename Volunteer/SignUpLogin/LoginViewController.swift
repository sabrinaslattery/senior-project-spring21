//
//  LoginViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 2/21/21.
//

import Foundation
import UIKit
import Parse


class LoginViewController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var forgotPasswordButton: UIButton!
    @IBOutlet weak var signuphereButton: UIButton!
    var continueButton:RoundedWhiteButton!
    var activityView:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        

        
        emailField.delegate = self
        passwordField.delegate = self
        
        emailField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)

    }
	
	
	override func viewDidAppear(_ animated: Bool) {
		//Check the user is already logged in
		let currentUser = PFUser.current()
		if currentUser != nil {
		  // Do stuff with the user
            print("\(String(describing: currentUser!.username))Already logged in")
			self.performSegue(withIdentifier: "LoginSegue", sender: self)
		} else {
			print("not logged in")
		}
	}
    
    // User Sign-in Validation
    @IBAction func onSignIn(_ sender: Any) {
		let username = emailField.text!
		let password = passwordField.text!
		
		PFUser.logInWithUsername(inBackground: username, password: password) { (user, error) in
			if user != nil && error == nil {
                self.performSegue(withIdentifier: "LoginSegue", sender: self)
                print(user?.description)
			} else {
				let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
				alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
					print(error.debugDescription)
				}))
				self.present(alert, animated: true)
			}
		}
}
	
    
	
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        emailField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    /**
     Adjusts the center of the **continueButton** above the keyboard.
     - Parameter notification: Contains the keyboardFrame info.
     */
    
    @objc func keyboardWillAppear(notification: NSNotification){
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
//        continueButton.center = CGPoint(x: view.center.x,
//                                        y: view.frame.height - keyboardFrame.height - 16.0 - continueButton.frame.height / 2)
//        activityView.center = continueButton.center
    }
    
    /**
     Enables the continue button if the **username**, **email**, and **password** fields are all non-empty.
     
     - Parameter target: The targeted **UITextField**.
     */
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = emailField.text
        let password = passwordField.text
        let formFilled = email != nil && email != "" && password != nil && password != ""
        //setContinueButton(enabled: formFilled)
    }

    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        // Resigns the target textField and assigns the next textField in the form.
        
        switch textField {
        case emailField:
            emailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
            break
        case passwordField:
            handleSignIn()
            break
        default:
            break
        }
        return true
    }
    
    /**
     Enables or Disables the **continueButton**.
     */
    
//    func setContinueButton(enabled:Bool) {
//        if enabled {
//            continueButton.alpha = 1.0
//            continueButton.isEnabled = true
//        } else {
//            continueButton.alpha = 0.5
//            continueButton.isEnabled = false
//        }
//    }
//
    @objc func handleSignIn() {
        guard emailField.text != nil else { return }
        guard passwordField.text != nil else { return }
        
//        setContinueButton(enabled: false)
//        continueButton.setTitle("", for: .normal)activityView.startAnimating()
        
        /* Auth.auth().signIn(withEmail: email, password: pass) { user, error in
            if error == nil && user != nil {
                self.dismiss(animated: false, completion: nil)
            } else {
                print("Error logging in: \(error!.localizedDescription)")
                
                self.resetForm()
            }
            
        } */
    }
    
    func resetForm() {
        let alert = UIAlertController(title: "Error logging in", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
//        setContinueButton(enabled: true)
//        continueButton.setTitle("Continue", for: .normal)
        activityView.stopAnimating()
    }
}
