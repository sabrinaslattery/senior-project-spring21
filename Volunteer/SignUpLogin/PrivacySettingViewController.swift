//
//  PrivacySettingViewController.swift
//  Volunteer
//
//  Created by William Ordaz, Sabrina and Josh Freedman on 2/22/21.
//

import Foundation
import UIKit

class PrivacySettingViewController:UIViewController {
    
    @IBOutlet weak var defaultButton: UIButton!
    @IBOutlet weak var organizerButton: UIButton!
    @IBOutlet weak var privateButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    var flag1 = false
    var flag2 = false
    var flag3 = false
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func defaultButton(_ sender: UIButton) {
        if (flag1 == true)
        {
            sender.setBackgroundImage((UIImage(systemName: "checkmark.circle.fill")), for: UIControl.State.normal)
            flag1 = false
        }
        else {
            sender.setBackgroundImage((UIImage(systemName: "circle")), for: UIControl.State.normal)
            flag1 = true
        }
    }
    
    
    @IBAction func organizerButton(_ sender: UIButton) {
        if (flag2 == false)
        {
            sender.setBackgroundImage((UIImage(systemName: "checkmark.circle.fill")), for: UIControl.State.normal)
            flag2 = true
        }
        else {
            sender.setBackgroundImage((UIImage(systemName: "circle")), for: UIControl.State.normal)
            flag2 = false
        }
    }
    
    @IBAction func privateButton(_ sender: UIButton) {
        if (flag3 == false)
        {
            sender.setBackgroundImage((UIImage(systemName: "checkmark.circle.fill")), for: UIControl.State.normal)
            flag3 = true
        }
        else {
            sender.setBackgroundImage((UIImage(systemName: "circle")), for: UIControl.State.normal)
            flag3 = false
        }
    }
    
}
