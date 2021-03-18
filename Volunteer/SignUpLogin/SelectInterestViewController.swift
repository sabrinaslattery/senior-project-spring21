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
    
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
}
