//
//  SignUpViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 2/21/21.
//

import Foundation
import UIKit
import Parse

class SignUpViewController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var firstnameField: UITextField!
    @IBOutlet weak var lastnameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tapToChangeProfileButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
 
    
    //var continueButton:RoundedWhiteButton!
    var activityView:UIActivityIndicatorView!
    
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        /*continueButton = RoundedWhiteButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        continueButton.setTitleColor(secondaryColor, for: .normal)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        continueButton.center = CGPoint(x: view.center.x, y: view.frame.height - continueButton.frame.height - 24)
        continueButton.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
        continueButton.defaultColor = UIColor.white
        // continueButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        
        view.addSubview(continueButton)
        setContinueButton(enabled: false)
        
        activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)
        activityView.color = secondaryColor
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = continueButton.center
        
        view.addSubview(activityView)
        */
        
        firstnameField.delegate = self
        lastnameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        
        firstnameField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        lastnameField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(imageTap)
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.clipsToBounds = true
        //tapToChangeProfileButton.addTarget(self, action: #selector(openImagePicker), for: .touchUpInside)
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)
    }
    
<<<<<<< HEAD
<<<<<<< Updated upstream
=======
=======
>>>>>>> main
    // Storing username and password in the database 
    @IBAction func signUp(_ sender: UIButton) {
        let user = PFUser()
        user.username = emailField.text!
        user.password = passwordField.text!
        
        user.signUpInBackground { (success, error) in
            if success{
                self.performSegue(withIdentifier: "LoginSegue", sender: nil)
            }
         else{
<<<<<<< HEAD
            print("Error: \(String(describing: error?.localizedDescription))")
=======
            print("Error: \(error?.localizedDescription)")
>>>>>>> main
         }
        
    }
}
    
<<<<<<< HEAD
>>>>>>> Stashed changes
=======
>>>>>>> main
    @objc func openImagePicker(_ sender:Any) {
        // Open Image Picker
        self.present(imagePicker, animated: true, completion: nil)
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
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    
    @objc func keyboardWillAppear(notification: NSNotification){
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        continueButton.center = CGPoint(x: view.center.x,
                                        y: view.frame.height - keyboardFrame.height - 16.0 - continueButton.frame.height / 2)
        activityView.center = continueButton.center
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
    
    
    // This section will be used when we have a database. We will connect it to that!
    /* @objc func handleSignUp() {
     guard let username = usernameField.text else { return }
     guard let email = emailField.text else { return }
     guard let pass = passwordField.text else { return }
     guard let image = profileImageView.image else { return }
     
     setContinueButton(enabled: false)
     continueButton.setTitle("", for: .normal)
     activityView.startAnimating()
     
     Auth.auth().createUser(withEmail: email, password: pass) { user, error in
     if error == nil && user != nil {
     
     print("User created!")
     
     // 1. Upload the profile image to Firebase Storage
     
     self.uploadProfileImage(image) { url in
     
     if url != nil {
     let changeRequest = Auth.auth().currentUser?.createProfileChangeRequest()
     changeRequest?.displayName = username
     changeRequest?.photoURL = url
     
     changeRequest?.commitChanges { error in
     if error == nil {
     print("User display name changed!")
     
     self.saveProfile(username: username, email:email, profileImageURL: url!) { success in
     if success {
     self.dismiss(animated: true, completion: nil)
     } else {
     self.resetForm()
     }
     }
     
     } else {
     print("Error: \(error!.localizedDescription)")
     self.resetForm()
     }
     }
     } else {
     self.resetForm()
     }
     }
     } else {
     self.resetForm()
     }
     }
     }
     */
    
    
    
    
    func resetForm() {
        let alert = UIAlertController(title: "Error signing up", message: nil, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        setContinueButton(enabled: true)
        continueButton.setTitle("Continue", for: .normal)
        activityView.stopAnimating()
    }
    
    
    // This section will be used when we have a database. We will connect it to that!
    
    /* func uploadProfileImage(_ image:UIImage, completion: @escaping ((_ url:URL?)->())) {
     guard let uid = Auth.auth().currentUser?.uid else { return }
     let storageRef = Storage.storage().reference().child("user/\(uid)")
     
     guard let imageData = UIImageJPEGRepresentation(image, 0.75) else { return }
     
     
     let metaData = StorageMetadata()
     metaData.contentType = "image/jpg"
     
     storageRef.putData(imageData, metadata: metaData) { metaData, error in
     if error == nil, metaData != nil {
     if let url = metaData?.downloadURL() {
     completion(url)
     } else {
     completion(nil)
     }
     // success!
     } else {
     // failed
     completion(nil)
     }
     }
     }
     */
    
    
    // This section will be used when we have a database. We will connect it to that!
    
    /* func saveProfile(username:String, email:String, profileImageURL:URL, completion: @escaping ((_ success:Bool)->())) {
     guard let uid = Auth.auth().currentUser?.uid else { return }
     let databaseRef = Database.database().reference().child("users/profile/\(uid)")
     
     let userObject = [
     "username": username,
     "email": email,
     "photoURL": profileImageURL.absoluteString
     ] as [String:Any]
     
     databaseRef.setValue(userObject) { error, ref in
     completion(error == nil)
     }
     }
     }
     */
}
extension SignUpViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    private func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.editedImage.rawValue] as? UIImage {
            self.profileImageView.image = pickedImage
        }
        
        picker.dismiss(animated: true, completion: nil)
    }
    
    
}
