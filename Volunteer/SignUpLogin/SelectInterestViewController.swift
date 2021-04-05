//
//  SelectInterestViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 2/22/21.
//

import Foundation
import UIKit

class SelectInterestViewController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
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
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
    
//    @IBAction func createProfile(_ sender: Any){
//        let user = PFObject(className:"Profile")
//        user ["interestTags"] = animalWelfareCheckbox.UIButton!
        
    //}
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    //interest tag buttons
    @IBAction func animalCheckboxButton(_ sender: UIButton) {
        if (flag1 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag1 = true
            
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag1 = false
        }
    }
    
    @IBAction func childCheckboxButton(_ sender: UIButton) {
        if (flag2 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag2 = true
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag2 = false
        }
    }
    
    @IBAction func communityCheckboxButton(_ sender: UIButton) {
        if (flag3 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag3 = true
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag3 = false
        }
    }
    
    @IBAction func educationCheckboxButton(_ sender: UIButton) {
        if (flag4 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag4 = true
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag4 = false
        }
    }
    
    @IBAction func elderlyCheckboxButton(_ sender: UIButton) {
        if (flag5 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag5 = true
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag5 = false
        }
    }
    
    @IBAction func healthCheckboxButton(_ sender: UIButton) {
        if (flag6 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag6 = true
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag6 = false
        }
    }
    
    @IBAction func homeCheckboxButton(_ sender: UIButton) {
        if (flag7 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag7 = true
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag7 = false
        }
    }
    
    @IBAction func otherCheckboxButton(_ sender: UIButton) {
        if (flag8 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag8 = true
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag8 = false
        }
    }
    
    @IBAction func poveryCheckboxButton(_ sender: UIButton) {
        if (flag9 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag9 = true
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag9 = false
        }
    }
    
    @IBAction func religionCheckboxButton(_ sender: UIButton) {
        if (flag10 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag10 = true
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag10 = false
        }
    }
    
    @IBAction func technologyCheckboxButton(_ sender: UIButton) {
        if (flag11 == false)
        {
            sender.setBackgroundImage((UIImage(named: "checkbox_checked")), for: UIControl.State.normal)
            flag11 = true
        }
        else {
            sender.setBackgroundImage((UIImage(named: "checkbox_unchecked")), for: UIControl.State.normal)
            flag11 = false
        }
    }
    
}
