//
//  CreateNewEventViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 3/22/21.
//

import Foundation
import UIKit
import Parse

class CreateNewEventViewController:UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var coverPhotoImageView: UIImageView!
    @IBOutlet weak var eventTitleField: UITextField!
    @IBOutlet weak var easyButton: UIButton!
    @IBOutlet weak var mediumButton: UIButton!
    @IBOutlet weak var hardButton: UIButton!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var fromField: UITextField!
    @IBOutlet weak var toField: UITextField!
    @IBOutlet weak var totalSpotsField: UITextField!
    @IBOutlet weak var aboutEventField: UITextField!
    @IBOutlet weak var volunteerExpectationField: UITextField!
    @IBOutlet weak var volunteerShouldWearField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!

    
    @IBOutlet weak var difficultyField: UITextField!
    @IBOutlet weak var tagField: UITextField!
    
    
    var difficultyPicker = UIPickerView()
    var tagsPicker = UIPickerView()
    
    let difficulty = ["Easy/Facil", "Medium/Mediano", "Hard/Deficil"]
    let tags = ["Animal Welfare", "Community Development", "Childcare", "Education", "Elderly care", "Health/Wellness", "Home Improvement", "Other", "Poverty/Hunger", "Religion", "Technology"]
        
        
        //"Animal Rescue Shelters", "Food Pantries", "Habitat for Humanity", "Local Libraries", "Museums", "YMCA", "Retirement Homes", "Red Cross", "Volunteering Abroad", "Church/Volunteers of America", "National Parks", "Hospital", "Homeless Shelter", "Park Clean Up/Preservation Efforts", "After School Tutoring"

    @IBOutlet weak var completeButton: UIButton!

    
    
    var activityView:UIActivityIndicatorView!
    
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)

        eventTitleField.delegate = self
        fromField.delegate = self
        toField.delegate = self
        totalSpotsField.delegate = self
        aboutEventField.delegate = self
        volunteerExpectationField.delegate = self
        volunteerShouldWearField.delegate = self
        emailField.delegate = self
        phoneNumberField.delegate = self
        
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func onCameraButton(_sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.allowsEditing = true
        
        if UIImagePickerController.isSourceTypeAvailable(.camera){
            picker.sourceType = .camera
        }
        
        else{
            picker.sourceType = .photoLibrary
        }
        
        present(picker, animated: true, completion: nil)
    }
    
    // resizing the image and
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to:size)
        
        coverPhotoImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
}
