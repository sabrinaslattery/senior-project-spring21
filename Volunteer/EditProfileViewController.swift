//
//  EditProfileViewController.swift
//  Volunteer
//
//  Created by Joshua Freedman on 3/30/21.
//


import Foundation
import UIKit

class EditProfileViewController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
 
    //need to continue finishing this part
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var tapToChangeProfileButton: UIButton!
    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet var control: UISegmentedControl!
    var imagePicker:UIImagePickerController!
    
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        
        let imageTap = UITapGestureRecognizer(target: self, action: #selector(openImagePicker))
        profileImageView.isUserInteractionEnabled = true
        profileImageView.addGestureRecognizer(imageTap)
        profileImageView.layer.cornerRadius = profileImageView.bounds.height / 2
        profileImageView.clipsToBounds = true
        
        imagePicker = UIImagePickerController()
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = (self as UIImagePickerControllerDelegate & UINavigationControllerDelegate)

        let intersetTags = ["Animal Welfare", "Community Development", "Childcare", "Education", "Elderly care", "Health/Wellness", "Home Improvement", "Other", "Poverty/Hunger", "Religion", "Technology"]
    }
    

    @objc func openImagePicker(_ sender:Any) {
    // Open Image Picker
    self.present(imagePicker, animated: true, completion: nil)
    
    }
    //Interest tags
    @IBAction func didChangeSegment(_ sender: UISegmentedControl){
        if sender.selectedSegmentIndex == 0 {
            
        }
        else if sender.selectedSegmentIndex == 1 {
            control.backgroundColor = .blue
        }
    }
    
    //education level dropdown menu lines 57-93
    @IBOutlet var educationButtons: [UIButton]!
    
    @IBAction func handleSelection(_ sender: UIButton) {
        educationButtons.forEach { (button) in
            UIView.animate(withDuration: 0.3, animations:{
                button.isHidden = !button.isHidden
                self.view.layoutIfNeeded()
            })
            
        }
    }
    
    enum EducationLevel: String {
        case highSchoolGraduate = "High School Graduate"
        case someCollege = "Some College Credit"
        case associateDegree = "Associate Degree"
        case bachelorDegree = "Bachelor's Degree"
    }
    

    @IBAction func educationTapped(_ sender: UIButton) {
        guard let title = sender.currentTitle, let eduction = EducationLevel(rawValue: title) else {
            return
        }
        
        switch eduction {
        case .highSchoolGraduate:
            print("High School Graduate")
        case .someCollege:
            print("Some College Credit")
        case .associateDegree:
            print("Associate Degree")
        case .bachelorDegree:
            print("Bachelor's Degree")
        }
    }
}
