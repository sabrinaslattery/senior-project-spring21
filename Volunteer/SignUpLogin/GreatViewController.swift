//
//  GreatViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 2/22/21.
//
import Parse
import Foundation
import UIKit

class GreatViewController:UIViewController {
    
    @IBOutlet weak var nextButton: UIButton!
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        let user = PFUser.current()
		user!["newUser"] = false
		user?.saveInBackground()
		print(user!["newUser"] as! Bool)
        
    }
    
}
