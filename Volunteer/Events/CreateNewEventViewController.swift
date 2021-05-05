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

class CreateNewEventViewController:UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var coverPhotoImageView: UIImageView!
    @IBOutlet weak var eventTitleField: UITextField!
    
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var toPicker: UIDatePicker!
    @IBOutlet weak var fromPicker: UIDatePicker!
    @IBOutlet weak var totalSpotsField: UITextField!
    
    @IBOutlet weak var aboutEventField: UITextView!
    @IBOutlet weak var volunteerExpectationField: UITextView!
    @IBOutlet weak var volunteerShouldWearField: UITextView!
    
    @IBOutlet weak var streetField: UITextField!
    @IBOutlet weak var cityField: UITextField!
    @IBOutlet weak var zipCodeField: UITextField!
    
    @IBOutlet weak var organizerNameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    @IBOutlet weak var difficultyField: UITextField!
    @IBOutlet weak var tagField: UITextField!

    var difficultyPicker = UIPickerView()
    var tagsPicker = UIPickerView()

    let difficulty = ["Easy", "Medium", "Hard"]
    let tags = ["Animal Welfare", "Community Development", "Childcare", "Education", "Elderly care", "Health/Wellness", "Home Improvement", "Other", "Poverty/Hunger", "Religion", "Technology"]
    
//    let tags = ["Animal Rescue Shelters", "Food Pantries", "Habitat for Humanity", "Local Libraries", "Museums", "YMCA", "Retirement Homes", "Red Cross", "Volunteering Abroad", "Church/Volunteers of America", "National Parks", "Hospital", "Homeless Shelter", "Park Clean Up/Preservation Efforts", "After School Tutoring"]
    
    var activityView:UIActivityIndicatorView!
    var imagePicker:UIImagePickerController!
    var event = PFObject(className: "Events")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
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
        totalSpotsField.delegate = self
        streetField.delegate = self
        cityField.delegate = self
        zipCodeField.delegate = self
        aboutEventField.delegate = self
        volunteerExpectationField.delegate = self
        volunteerShouldWearField.delegate = self
        organizerNameField.delegate = self
        emailField.delegate = self
        phoneNumberField.delegate = self
        
        aboutEventField!.layer.borderWidth = 1
        aboutEventField!.layer.borderColor = UIColor.black.cgColor
        volunteerExpectationField!.layer.borderWidth = 1
        volunteerExpectationField!.layer.borderColor = UIColor.black.cgColor
        volunteerShouldWearField!.layer.borderWidth = 1
        volunteerShouldWearField!.layer.borderColor = UIColor.black.cgColor
        
        eventTitleField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        totalSpotsField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        emailField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
        phoneNumberField.addTarget(self, action: #selector(textFieldChanged(_:)), for: .editingChanged)
    }

    @IBAction func CompletedButton(_ sender: Any) {
    
        self.event["title"] = eventTitleField.text!
        self.event["totalSpots"] = Int(totalSpotsField.text!) ?? Int(0)
        self.event["description"] = aboutEventField.text!
        self.event["expectations"] = volunteerExpectationField.text!
        self.event["clothes"] = volunteerShouldWearField.text!
        
        self.event["contactName"] = organizerNameField.text!
        self.event["contactEmail"] = emailField.text!
        self.event["contactPhone"] = phoneNumberField.text!
               
//        self.event["difficulty"] = difficultyPicker
//        self.event["tag"] = tagsPicker
        
        self.event["streetLocation"] = streetField.text! + String(", CA")
        self.event["cityLocation"] = cityField.text!
        self.event["zipCodeLocation"] = zipCodeField.text!
        
        datePicker.locale = .current
        toPicker.locale = .current
        fromPicker.locale = .current
        self.event["date"] = datePicker.date
        self.event["startTime"] = fromPicker.date
        self.event["endTime"] = toPicker.date
        event["attendees"] = NSArray()
               
        let imageData = coverPhotoImageView.image!.pngData()
        let file = PFFileObject(data: imageData!)
               
        event["image"] = file
               
        _ = datePicker.date

        // MARK: - User must click fillout title, contact email, about event, volunteer expectation and wear, phone # and total spots
        if !eventTitleField.hasText || !emailField.hasText || !aboutEventField.hasText ||
            !volunteerExpectationField.hasText ||
            !volunteerShouldWearField.hasText || !organizerNameField.hasText ||
            !phoneNumberField.hasText ||
            !totalSpotsField.hasText || !streetField.hasText || !cityField.hasText || !zipCodeField.hasText
        {
            let alert = UIAlertController(title: "Oops!", message: "Please fill out the required infomation!", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                print("Please fill out fields!")
            }))
            self.present(alert, animated: true)
            
            } else {
            event.saveInBackground { (success, error) in
                if success {
                    let alert = UIAlertController(title: "Event Created!", message:"Your event has been created. Check the  'Manage My Events' tab to view details.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title:"Ok", style: .default, handler: {
                        (action) in
                        print("Created Successfully")
                    }))
                    self.present(alert, animated: true)
                    self.performSegue(withIdentifier: "reloadPage", sender: nil)
                } else  {
                    
                    let alert = UIAlertController(title: "Oops!", message: error?.localizedDescription, preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                        print(error.debugDescription)
                    }))
                    self.present(alert, animated: true)
                }
            }
        }
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
        let scaledImage = image.af.imageScaled(to:size)
        
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
        fromPicker.resignFirstResponder()
        toPicker.resignFirstResponder()
        streetField.resignFirstResponder()
        cityField.resignFirstResponder()
        zipCodeField.resignFirstResponder()
        totalSpotsField.resignFirstResponder()
        aboutEventField.resignFirstResponder()
        volunteerExpectationField.resignFirstResponder()
        volunteerShouldWearField.resignFirstResponder()
        organizerNameField.resignFirstResponder()
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
        let total = totalSpotsField.text
        let about = aboutEventField.text
        let street = streetField.text
        let city = cityField.text
        let zip = zipCodeField.text
        let expectation = volunteerExpectationField.text
        let name = organizerNameField.text
        let email = emailField.text
        let number = phoneNumberField.text
        
        _ = title != nil && title != "" && total != nil && total != "" && about != nil && about != "" && expectation != nil && expectation != "" && email != nil && email != "" && number != nil && number != "" && name != nil && name != "" && street != nil && street != "" && city != nil && city != "" && zip != nil && zip != ""
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
        //let event = PFObject(className: "Events")
        switch pickerView.tag {
        case 1:
            self.event["difficulty"] = self.difficulty[row]
            difficultyField.text = difficulty[row]
            difficultyField.resignFirstResponder()
        case 2:
            self.event["tag"] = self.tags[row]
            tagField.text = tags[row]
            tagField.resignFirstResponder()
        default:
            return
        }
    }
}
