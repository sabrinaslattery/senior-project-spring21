//
//  EditEventViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 4/15/21.
//

import UIKit
import Parse
import AlamofireImage

class EditEventViewController:UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var coverPhotoImageView: UIImageView!
    @IBOutlet weak var eventTitleField: UITextField!
    @IBOutlet weak var difficultyField: UITextField!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var fromPicker: UIDatePicker!
    @IBOutlet weak var toPicker: UIDatePicker!
    @IBOutlet weak var totalSpotsField: UITextField!
    @IBOutlet weak var tagField: UITextField!
    @IBOutlet weak var aboutEventField: UITextView!
    @IBOutlet weak var volunteerExpectationField: UITextView!
    @IBOutlet weak var volunteerShouldWearField: UITextView!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var phoneNumberField: UITextField!
    
    var difficultyPicker = UIPickerView()
    var tagsPicker = UIPickerView()
    
    let difficulty = ["Easy", "Medium", "Hard"]
    
    let tags = ["Animal Welfare", "Community Development", "Childcare", "Education", "Elderly care", "Health/Wellness", "Home Improvement", "Other", "Poverty/Hunger", "Religion", "Technology"]
    
    //let tags = ["Animal Rescue Shelters", "Food Pantries", "Habitat for Humanity", "Local Libraries", "Museums", "YMCA", "Retirement Homes", "Red Cross", "Volunteering Abroad", "Church/Volunteers of America", "National Parks", "Hospital", "Homeless Shelter", "Park Clean Up/Preservation Efforts", "After School Tutoring"]
    
    
    var activityView:UIActivityIndicatorView!
    
    var imagePicker:UIImagePickerController!
    
    var event = PFObject(className: "Events")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        showUserData()
        showProfileImage()
        
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
        
        aboutEventField!.layer.borderWidth = 1
        aboutEventField!.layer.borderColor = UIColor.black.cgColor
        volunteerExpectationField!.layer.borderWidth = 1
        volunteerExpectationField!.layer.borderColor = UIColor.black.cgColor
        volunteerShouldWearField!.layer.borderWidth = 1
        volunteerShouldWearField!.layer.borderColor = UIColor.black.cgColor
    }
    
    func showProfileImage () {
            //let user = PFUser.current()
            let query = PFQuery(className: "Events")
            query.whereKey("user", equalTo:  PFUser.current()!)
            query.includeKey("image")
            query.findObjectsInBackground { (result: [PFObject]!, error: Error?) in
            if let result = result {
                for list in result{

                    let output:PFFileObject = list["image"] as! PFFileObject
                    output.getDataInBackground { (ImageData: Data?, error: Error?) in
                        if error == nil {

                            let Image: UIImage = UIImage (data: ImageData!)!
                            self.coverPhotoImageView?.image = Image
                        }
                    }
    //                        let output = list["image"] as? PFFileObject
    //                        self.profileImage.image!.pngData() = output

                  }
               }
            }
        }
    
    func showUserData() {
        let query = PFQuery(className: "Events")
        query.whereKey("user", equalTo: PFUser.current()!)
        query.includeKeys(["title","totalSpots","description","expectations","clothes","contactEmail","contactPhone",
                            "date", "startTime", "endTime", "difficulty", "tag"])
        query.findObjectsInBackground { (result: [PFObject]!, error: Error?) in
          if let result = result {
            for list in result{
              let eventTitle = list["title"] as? String
              let eventTotalSpots = list["totalSpots"] as? String
              let eventDesc = list["description"] as? String
              let eventExpectation = list["expectations"] as? String
              let eventClothes = list["clothes"] as? String
              let eventEmail = list["contactEmail"] as? String
              let eventPhone = list["contactPhone"] as? String
              let eventDate = list["date"] as? Date
              let eventStartTime = list["startTime"] as? Date
              let eventEndTime = list["endTime"] as? Date
              let eventDiff = list["difficulty"] as? String
              let eventTag = list["tag"] as? String
              self.eventTitleField?.text = eventTitle
              self.totalSpotsField?.text = eventTotalSpots
              self.aboutEventField?.text = eventDesc
              self.volunteerExpectationField?.text = eventExpectation
              self.volunteerShouldWearField?.text = eventClothes
              self.emailField?.text = eventEmail
              self.phoneNumberField?.text = eventPhone
              self.datePicker?.date = eventDate!
              self.fromPicker?.date = eventStartTime!
              self.toPicker?.date = eventEndTime!
              self.difficultyField?.text = eventDiff
              self.tagField?.text = eventTag

            }
          }
          }
      }
    
    @IBAction func updateEvent(_ sender: Any) {
            let currentEvent = PFUser.current()
            self.event["title"] = eventTitleField.text!
            self.event["totalSpots"] = Int(totalSpotsField.text!)
            self.event["description"] = aboutEventField.text!
            self.event["expectations"] = volunteerExpectationField.text!
            self.event["clothes"] = volunteerShouldWearField.text!
            self.event["contactEmail"] = emailField.text!
            self.event["contactPhone"] = phoneNumberField.text!
            self.event["difficulty"] = difficultyField.text!
            self.event["tag"] = tagField.text!
            self.event["Events"] = currentEvent
            datePicker.locale = .current
            toPicker.locale = .current
            fromPicker.locale = .current
            self.event["date"] = datePicker.date
            self.event["startTime"] = fromPicker.date
            self.event["endTime"] = toPicker.date
            self.event["attendees"] = NSArray()
        
            // saving the profile image
            let imageData = coverPhotoImageView.image!.pngData()
            let file = PFFileObject(data: imageData!)
            self.event["image"] = file
            
            self.event.saveInBackground {
              (success: Bool, error: Error?) in
              if (success) {
                
                // The object has been saved.
              } else {
                // There was a problem, check error.description
              }
            }
          }

    // Launching the camera to add a profile picture from camera or photo library
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
        let scaledImage = image.af.imageScaled(to:size)
        
        coverPhotoImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
}
extension EditEventViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
            //PFUser.current()?.saveInBackground()
            difficultyField.text = difficulty[row]
            difficultyField.resignFirstResponder()
        case 2:
            self.event["tag"] = self.tags[row]
            //PFUser.current()?.saveInBackground()
            tagField.text = tags[row]
            tagField.resignFirstResponder()
        default:
            return
        }
    }
    
}
