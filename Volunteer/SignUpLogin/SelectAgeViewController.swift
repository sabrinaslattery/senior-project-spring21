//
//  SelectAgeViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 2/22/21.
//

import Foundation
import UIKit


class SelectAgeViewController:UIViewController {
    
    @IBOutlet weak var twelveButton: UIButton!
    @IBOutlet weak var sixteenButton: UIButton!
    @IBOutlet weak var eighteenButton: UIButton!
    @IBOutlet weak var continueButton: UIButton!
    
    
    override func viewDidLoad() {
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
    }
    
}
