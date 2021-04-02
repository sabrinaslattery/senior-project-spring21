//
//  CreateNewEventViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 3/22/21.
//

import Foundation
import UIKit
import Parse
import AlamofireImage

class CreateNewEventViewController:UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var coverPhotoImageView: UIImageView!
    @IBOutlet weak var eventTitleField: UITextField!
    
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
    
    //let tags = ["Animal Rescue Shelters", "Food Pantries", "Habitat for Humanity", "Local Libraries", "Museums", "YMCA", "Retirement Homes", "Red Cross", "Volunteering Abroad", "Church/Volunteers of America", "National Parks", "Hospital", "Homeless Shelter", "Park Clean Up/Preservation Efforts", "After School Tutoring"]
    
    
    var activityView:UIActivityIndicatorView!
    
    var imagePicker:UIImagePickerController!
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        difficultyField.inputView = difficultyPicker
        tagField.inputView = tagsPicker
        
        difficultyPicker.dataSource = self
        difficultyPicker.delegate = self
        
        tagsPicker.dataSource = self
        tagsPicker.delegate = self
        
        difficultyPicker.tag = 1
        tagsPicker.tag = 2
        
        difficultyField.placeholder = "Select difficulty"
        tagField.placeholder = "Select Corresponding Tag"
        
        difficultyField.textAlignment = .center
        tagField.textAlignment = .center

        eventTitleField.delegate = self
        fromField.delegate = self
        toField.delegate = self
        totalSpotsField.delegate = self
        aboutEventField.delegate = self
        volunteerExpectationField.delegate = self
        volunteerShouldWearField.delegate = self
        emailField.delegate = self
        phoneNumberField.delegate = self
        
        eventTitleField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        fromField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        toField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        totalSpotsField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        aboutEventField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        volunteerExpectationField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        volunteerShouldWearField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        emailField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        phoneNumberField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        
    }
    
    @IBAction func CompletedButton(_ sender: Any) {
        
        let event = PFObject(className: "Events")
       
        event["title"] = eventTitleField.text!
        event["date"] = fromField.text!
       // event ["date"] = toField.text!
        event["spots"] = totalSpotsField.text!
        event ["aboutEvent"] = aboutEventField.text!
        event ["volExpectation"] = volunteerExpectationField.text!
        event ["volWear"] = volunteerShouldWearField.text!
        event["contactEmail"] = emailField.text!
        event ["contactNumber"] = phoneNumberField.text!
        
		event ["eventDiff"] = difficultyPicker
        event ["eventTag"] = tagsPicker
        event ["eventDate"] = datePicker
        
        
        let coverPhoto = PFObject(className: "CoverImage.png")
        let imageData = coverPhotoImageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
        
        coverPhoto["eventImage"] = file
        
        _ = datePicker.date
        
        let diffPicker = difficultyPicker
        let tagPicker = tagsPicker
        
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
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.editedImage] as! UIImage
        
        let size = CGSize(width: 300, height: 300)
        let scaledImage = image.af_imageScaled(to:size)
        
        coverPhotoImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        eventTitleField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        eventTitleField.resignFirstResponder()
        fromField.resignFirstResponder()
        toField.resignFirstResponder()
        totalSpotsField.resignFirstResponder()
        aboutEventField.resignFirstResponder()
        volunteerExpectationField.resignFirstResponder()
        volunteerShouldWearField.resignFirstResponder()
        emailField.resignFirstResponder()
        phoneNumberField.resignFirstResponder()
        
        NotificationCenter.default.removeObserver(self)
        
    }
    @objc func keyboardWillAppear(notification: NSNotification){
        
        let info = notification.userInfo!
        let _: CGRect = (info[UIResponder.keyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
       
    }
    
    @objc func textFieldChanged(_ target:UITextField) {
        let title = eventTitleField.text
        let from = fromField.text
        let to = toField.text
        let total = totalSpotsField.text
        let about = aboutEventField.text
        let expectation = volunteerExpectationField.text
        let email = emailField.text
        let number = phoneNumberField.text
        
        
        _ = title != nil && title != "" && from != nil && from != "" && to != nil && to != "" && total != nil && total != "" && about != nil && about != "" && expectation != nil && expectation != "" && email != nil && email != "" && number != nil && number != "" 
    }
    
}
extension CreateNewEventViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return difficulty.count
        case 2:
            return tags.count
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return difficulty[row]
        case 2:
            return tags[row]
        default:
            return "Data not found"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            PFUser.current()?["eventDiff"] = self.difficulty[row];
            PFUser.current()?.saveInBackground()
            difficultyField.text = difficulty[row]
            difficultyField.resignFirstResponder()
        case 2:
            PFUser.current()?["eventTag"] = self.tags[row];
            PFUser.current()?.saveInBackground()
            tagField.text = tags[row]
            tagField.resignFirstResponder()
        default:
            return
        }
    }
}
