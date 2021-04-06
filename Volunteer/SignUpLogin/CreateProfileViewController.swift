//
//  CreateProfileViewController.swift
//  Volunteer
//
//  Created by William Ordaz, Josh Freedman, Karina and Jessica on 2/22/21.
//

import Foundation
import UIKit
import Parse

class CreateProfileViewController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var jobTitleTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipCodeTextField: UITextField!
    @IBOutlet weak var continueButton: UIButton!
    @IBOutlet weak var educationLevelField: UITextField!
    
    var educationLevelPicker = UIPickerView()
    
    let educationLevel = ["High School Graduate", "Some College", "Associate Degree", "Bachelor's Degree", "Master's Degree", "Higher Degree"]
    
    
    //other dropdown button
    //var buttonEducationLevel = dropDownBtn()
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        educationLevelField.inputView = educationLevelPicker
                
        educationLevelPicker.dataSource = self
        educationLevelPicker.delegate = self
        
        educationLevelPicker.tag = 1
        
        educationLevelField.placeholder = "Select Education Level"
        
        educationLevelField.textAlignment = .center
        
        
        //other dropdown button
//        buttonEducationLevel = dropDownBtn.init(frame: CGRect(x: 23, y: 605, width: 250, height: 26.5))
//        buttonEducationLevel.setTitle("Select Education Level", for: .normal)
//        buttonEducationLevel.setTitleColor(.black, for: .normal)
//        //buttonEducationLevel.translatesAutoresizingMaskIntoConstraints = false
//
//        self.view.addSubview(buttonEducationLevel)
//
//        buttonEducationLevel.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
//        buttonEducationLevel.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
//
//        buttonEducationLevel.widthAnchor.constraint(equalToConstant: 250).isActive = true
//        buttonEducationLevel.heightAnchor.constraint(equalToConstant: 40).isActive = true
//
//        buttonEducationLevel.dropView.dropDownOptions = ["High School Graduate", "Some College", "Associate Degree", "Bachelor's Degree", "Master's Degree", "Higher Degree"]
    }
    
    @IBAction func createProfile(_ sender: Any){
        let currentUser = PFUser.current()
        let user = PFObject(className:"Profile")
        user ["jobTitle"] = jobTitleTextField.text!
        user ["city"] = cityTextField.text!
        user["zipCode"] = zipCodeTextField.text!
        user["user"] = currentUser
        
        user.saveInBackground {
            (success: Bool, error: Error?) in
            if (success) {
                // The object has been saved.
            } else {
                // There was a problem, check error.description
            }
        }
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
    }
}

//protocol dropDownProtocol {
//    func dropDownPressed(string : String)
//}

//class dropDownBtn: UIButton, dropDownProtocol {
//
//    func dropDownPressed(string: String) {
//        self.setTitle(string, for: .normal)
//        self.dissmissDropDown()
//    }
//
//
//    var dropView = dropDownView()
//
//    var height = NSLayoutConstraint()
//
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//
//        self.backgroundColor = UIColor.white
//        //orginally dropView = dropDownView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
//        dropView = dropDownView.init(frame: CGRect.init(x: 23, y: 605, width: 250, height: 26.5))
//        dropView.delegate = self
//        dropView.translatesAutoresizingMaskIntoConstraints = false
//
//    }
//
//    override func didMoveToSuperview() {
//        self.superview?.addSubview(dropView)
//        //how we want our drop view to come down, front or back? self.superview?.bringSubview(toFront: dropView)
//        self.superview?.bringSubviewToFront(dropView)
//        dropView.topAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//        dropView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
//        dropView.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
//        height = dropView.heightAnchor.constraint(equalToConstant: 0)
//    }
//
//    var isOpen = false
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        if isOpen == false {
//
//            isOpen = true
//
//            NSLayoutConstraint.deactivate([self.height])
//
//            if self.dropView.tableView.contentSize.height > 250 {
//                self.height.constant = 250
//            } else {
//                self.height.constant = self.dropView.tableView.contentSize.height
//            }
//
//
//
//            NSLayoutConstraint.activate([self.height])
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//                self.dropView.layoutIfNeeded()
//            }, completion: nil)
//
//
//        } else {
//            isOpen = false
//
//            NSLayoutConstraint.deactivate([self.height])
//            self.height.constant = 0
//            NSLayoutConstraint.activate([self.height])
//            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//                self.dropView.center.y -= self.dropView.frame.height / 2
//                self.dropView.layoutIfNeeded()
//            }, completion: nil)
//
//        }
//    }
//
//
//    func dissmissDropDown(){
//        isOpen = false
//        NSLayoutConstraint.deactivate([self.height])
//        self.height.constant = 0
//        NSLayoutConstraint.activate([self.height])
//        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
//            self.dropView.center.y -= self.dropView.frame.height / 2
//            self.dropView.layoutIfNeeded()
//        }, completion: nil)
//
//    }
//        required init?(coder: NSCoder) {
//            fatalError("init(coder:) has not been implemented")
//        }
//}
//
//
//
//class dropDownView: UIView, UITableViewDelegate, UITableViewDataSource{
//
//    var dropDownOptions = [String]()
//
//    var tableView = UITableView()
//
//    var delegate : dropDownProtocol!
//
//    override init(frame: CGRect) {
//        super.init(frame: frame)
//
//        tableView.backgroundColor = UIColor.white
//        self.backgroundColor = UIColor.white
//
//        tableView.delegate = self
//        tableView.dataSource = self
//
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//
//        self.addSubview(tableView)
//
//        tableView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
//        tableView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
//        tableView.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
//    }
//
//
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return dropDownOptions.count
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
//        var cell = UITableViewCell()
//
//        cell.textLabel?.text = dropDownOptions[indexPath.row]
//        cell.backgroundColor = UIColor.white
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //call the delegate and pass along the data of the string value
//        self.delegate.dropDownPressed(string: dropDownOptions[indexPath.row])
//        self.tableView.deselectRow(at: indexPath, animated: true)
//        print(dropDownOptions[indexPath.row])
//    }
    

extension CreateProfileViewController: UIPickerViewDataSource, UIPickerViewDelegate {
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
            PFUser.current()?["educationLevel"] = self.educationLevel[row];
            PFUser.current()?.saveInBackground()
            educationLevelField.text = educationLevel[row]
            educationLevelField.resignFirstResponder()
        default:
            return
        }
    }
}
