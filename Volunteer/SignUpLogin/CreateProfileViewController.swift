//
//  CreateProfileViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 2/22/21.
//

import Foundation
import UIKit

class CreateProfileViewController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tapToChangeProfileButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var usernameTextField: UITextField!
    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var educationLevelTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    
    var imagePicker:UIImagePickerController!
    
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        
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
    

@objc func openImagePicker(_ sender:Any) {
    // Open Image Picker
    self.present(imagePicker, animated: true, completion: nil)
    
    }
    
}





extension CreateProfileViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
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
