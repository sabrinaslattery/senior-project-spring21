//
//  EditProfileViewController.swift
//  Volunteer
//
//  Created by Joshua Freedman, Jessica and Karina on 3/30/21.
//

import Foundation
import UIKit
import Parse
import AlamofireImage


class EditProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tapToChangeProfileButton: UIButton!
    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var introTextField: UITextField!
    @IBOutlet weak var workExperienceTextField: UITextField!
    @IBOutlet weak var educationLevelField: UITextField!
    
    //@IBOutlet var control: UISegmentedControl!
    //var imagePicker:UIImagePickerController!
    
    var educationLevelPicker = UIPickerView()
    
    let educationLevel = ["High School Graduate", "Some College", "Associate Degree", "Bachelor's Degree", "Master's Degree", "Higher Degree"]
	let interestTags = ["Animal Welfare", "Community Development", "Childcare", "Education", "Elderly care", "Health/Wellness", "Home Improvement", "Other", "Poverty/Hunger", "Religion", "Technology"]
    
    var profile = PFObject(className: "Profile")


    //Interest Checkboxes
    @IBOutlet weak var animalWelfareCheckbox: UIButton!
    @IBOutlet weak var childCareCheckbox: UIButton!
    @IBOutlet weak var commDevCheckbox: UIButton!
    @IBOutlet weak var educationCheckbox: UIButton!
    @IBOutlet weak var elderlyCareCheckbox: UIButton!
    @IBOutlet weak var healthCheckbox: UIButton!
    @IBOutlet weak var homeImproveCheckbox: UIButton!
    @IBOutlet weak var otherCheckbox: UIButton!
    @IBOutlet weak var povertyCheckbox: UIButton!
    @IBOutlet weak var religionCheckbox: UIButton!
    @IBOutlet weak var technologyCheckbox: UIButton!
    
    
    var flag1 = false
    var flag2 = false
    var flag3 = false
    var flag4 = false
    var flag5 = false
    var flag6 = false
    var flag7 = false
    var flag8 = false
    var flag9 = false
    var flag10 = false
    var flag11 = false
	
	
    
   //var buttonEducationLevel = dropDownBtn()
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        showUserData()
        showProfileImage()

        
        educationLevelField.inputView = educationLevelPicker
                
        educationLevelPicker.dataSource = self
        educationLevelPicker.delegate = self
        
        educationLevelPicker.tag = 1
        
        educationLevelField.placeholder = "Select Education Level"
        
        educationLevelField.textAlignment = .center
		
		//The interest tags already chosen should already have the checkbox clicked image. Uncomment when ready
		/*
		let interestsQuery = PFQuery(className:"Profile")
		interestsQuery.whereKey("user", equalTo:  PFUser.current()!)
		interestsQuery.includeKey("selectedTags")
		interestsQuery.findObjectsInBackground { (profiles, error) in
			if let error = error {
				print(error.localizedDescription)
			} else if let profiles = profiles {
				for profile in profiles {
					let tagsList = profile.object(forKey: "selectedTags") as? NSArray
					for tag in tagsList! {
						if self.interestTags.contains(tag as! String) {
							switch tag as! String {
							case self.interestTags[0]:
								self.flag1 = true
							case self.interestTags[2]:
								self.flag2 = true
							case self.interestTags[1]:
								self.flag3 = true
							case self.interestTags[3]:
								self.flag4 = true
							case self.interestTags[4]:
								self.flag5 = true
							case self.interestTags[5]:
								self.flag6 = true
							case self.interestTags[6]:
								self.flag7 = true
							case self.interestTags[7]:
								self.flag8 = true
							case self.interestTags[8]:
								self.flag9 = true
							case self.interestTags[9]:
								self.flag10 = true
							case self.interestTags[10]:
								self.flag11 = true
							default:
								continue
							}
						}
					}
				}
			}
		} */
        
        
//        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
//        profileImageView.isUserInteractionEnabled = true
//        profileImageView.addGestureRecognizer(imageTap)
//        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
//        profileImageView.clipsToBounds = true

//        imagePicker = UIImagePickerController()
//        imagePicker.allowsEditing = true
//        imagePicker.sourceType = .photoLibrary
//        imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)

        //let intersetTags = ["Animal Welfare", "Community Development", "Childcare", "Education", "Elderly care", "Health/Wellness", "Home Improvement", "Other", "Poverty/Hunger", "Religion", "Technology"]
        
//        buttonEducationLevel = dropDownBtn.init(frame: CGRect(x: 0, y: 0, width:0, height: 0))
//        buttonEducationLevel.translatesAutoresizingMaskIntoConstraints = false
//        
//        self.view.addSubview(buttonEducationLevel)
//        
//        buttonEducationLevel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        buttonEducationLevel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        
    }
    
    func showProfileImage () {
            let query = PFQuery(className: "Profile")
            query.whereKey("user", equalTo:  PFUser.current()!)
            query.includeKey("image")
            query.findObjectsInBackground { (result: [PFObject]!, error: Error?) in
            if let result = result {
                for list in result{

                    let output:PFFileObject = list["image"] as! PFFileObject
                    output.getDataInBackground { (ImageData: Data?, error: Error?) in
                        if error == nil {

                            let Image: UIImage = UIImage (data: ImageData!)!
                            self.profileImageView?.image = Image
                        }
                    }
    //                        let output = list["image"] as? PFFileObject
    //                        self.profileImage.image!.pngData() = output

                  }
               }
            }
        }
    
    func showUserData() {
        let query = PFQuery(className: "Profile")
        query.whereKey("user", equalTo: PFUser.current()!)
        query.includeKeys(["jobTitle","city","zipCode","educationLevel","userBio","workExperience"])
        query.findObjectsInBackground { (result: [PFObject]!, error: Error?) in
          if let result = result {
            for list in result{
              let userJobTitle = list["jobTitle"] as? String
              let userCity = list["city"] as? String
              let userZipCode = list["zipCode"] as? String
              let userIntro = list["userBio"] as? String
              let userWorkExperience = list["workExperience"] as? String
              let userEducationLevel = list["educationLevel"] as? String
              self.jobTitleTextField?.text = userJobTitle
              self.cityTextField?.text = userCity
              self.zipCodeTextField?.text = userZipCode
              self.introTextField?.text = userIntro
              self.workExperienceTextField?.text = userWorkExperience
              self.educationLevelField?.text = userEducationLevel
            }
          }
          }
      }
    
    
    
    @IBAction func updateUser(_ sender: Any) {
        let currentUser = PFUser.current()
            self.profile["jobTitle"] = jobTitleTextField.text!
            self.profile["city"] = cityTextField.text!
            self.profile["zipCode"] = zipCodeTextField.text!
            self.profile["userBio"] = introTextField.text!
            self.profile["workExperience"] = workExperienceTextField.text!
            self.profile["user"] = currentUser
            let eduLevelPicker = educationLevelPicker
        
            // saving the profile image
            let imageData = profileImageView.image!.pngData()
            let file = PFFileObject(data: imageData!)
            self.profile["image"] = file
            
            self.profile.saveInBackground {
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
        let scaledImage = image.af_imageScaled(to:size)
        
        profileImageView.image = scaledImage
        
        dismiss(animated: true, completion: nil)
    }

    //interest tag buttons
    @IBAction func animalCheckboxButton(_ sender: UIButton) {
        if (flag1 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag1 = true
			self.profile.addUniqueObject(self.interestTags[0], forKey: "selectedTags")
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag1 = false
			self.profile.remove(self.interestTags[0], forKey: "selectedTags")
        }
    }
    
    @IBAction func childCheckboxButton(_ sender: UIButton) {
        if (flag2 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag2 = true
			self.profile.addUniqueObject(self.interestTags[2], forKey: "selectedTags")
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag2 = false
			self.profile.remove(self.interestTags[2], forKey: "selectedTags")
        }
    }
    
    @IBAction func communityCheckboxButton(_ sender: UIButton) {
        if (flag3 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag3 = true
			self.profile.addUniqueObject(self.interestTags[1], forKey: "selectedTags")
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag3 = false
			self.profile.remove(self.interestTags[1], forKey: "selectedTags")
        }
    }
    
    @IBAction func educationCheckboxButton(_ sender: UIButton) {
        if (flag4 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag4 = true
			self.profile.addUniqueObject(self.interestTags[3], forKey: "selectedTags")
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag4 = false
			self.profile.remove(self.interestTags[3], forKey: "selectedTags")
        }
    }
    
    @IBAction func elderlyCheckboxButton(_ sender: UIButton) {
        if (flag5 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag5 = true
			self.profile.addUniqueObject(self.interestTags[4], forKey: "selectedTags")
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag5 = false
			self.profile.remove(self.interestTags[4], forKey: "selectedTags")
        }
    }
    
    @IBAction func healthCheckboxButton(_ sender: UIButton) {
        if (flag6 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag6 = true
			self.profile.addUniqueObject(self.interestTags[5], forKey: "selectedTags")
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag6 = false
			self.profile.remove(self.interestTags[5], forKey: "selectedTags")
        }
    }
    
    @IBAction func homeCheckboxButton(_ sender: UIButton) {
        if (flag7 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag7 = true
			self.profile.addUniqueObject(self.interestTags[6], forKey: "selectedTags")
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag7 = false
			self.profile.remove(self.interestTags[6], forKey: "selectedTags")
        }
    }
    
    @IBAction func otherCheckboxButton(_ sender: UIButton) {
        if (flag8 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag8 = true
			self.profile.addUniqueObject(self.interestTags[7], forKey: "selectedTags")
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag8 = false
			self.profile.remove(self.interestTags[7], forKey: "selectedTags")
        }
    }
    
    @IBAction func poveryCheckboxButton(_ sender: UIButton) {
        if (flag9 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag9 = true
			self.profile.addUniqueObject(self.interestTags[8], forKey: "selectedTags")
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag9 = false
			self.profile.remove(self.interestTags[8], forKey: "selectedTags")
        }
    }
    
    @IBAction func religionCheckboxButton(_ sender: UIButton) {
        if (flag10 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag10 = true
			self.profile.addUniqueObject(self.interestTags[9], forKey: "selectedTags")
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag10 = false
			self.profile.remove(self.interestTags[9], forKey: "selectedTags")
        }
    }
    
    @IBAction func technologyCheckboxButton(_ sender: UIButton) {
        if (flag11 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag11 = true
			self.profile.addUniqueObject(self.interestTags[10], forKey: "selectedTags")
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag11 = false
			self.profile.remove(self.interestTags[10], forKey: "selectedTags")
        }
    }
    
    
}
extension EditProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch pickerView.tag {
        case 1:
            return educationLevel.count
        default:
            return 1
        }
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch pickerView.tag {
        case 1:
            return educationLevel[row]
        default:
            return "Data not found"
        }
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView.tag {
        case 1:
            self.profile["educationLevel"] = self.educationLevel[row]
            educationLevelField.text = educationLevel[row]
            educationLevelField.resignFirstResponder()
        default:
            return
        }
    }
    
    @IBAction func handledViewPop(_ sender:Any){
        _ = navigationController?.popViewController(animated: true)
    }
    
}

