//
//  PrivacySettingViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 2/22/21.
//

import Foundation
import UIKit
import Parse

class PrivacySettingViewController:UIViewController {
    
    @IBOutlet weak var defaultButton: UIButton!
    @IBOutlet weak var organizerButton: UIButton!
    @IBOutlet weak var privateButton: UIButton!
    @IBOutlet weak var completeButton: UIButton!
    @IBOutlet weak var dismissButton: UIButton!
    
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
