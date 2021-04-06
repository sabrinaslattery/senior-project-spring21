//
//  EventViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 4/2/21.
//

import Foundation
import UIKit
import Parse

class EventViewController:UIViewController {
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var difficultyImage: UIImageView!
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var dateFromLabel: UILabel!
    @IBOutlet weak var dateToLabel: UILabel!
    @IBOutlet weak var eventLocationLabel: UILabel!
    @IBOutlet weak var spotsFilledLabel: UILabel!
    @IBOutlet weak var aboutEventLabel: UILabel!
    @IBOutlet weak var eventExpectationLabel: UILabel!
    @IBOutlet weak var shouldWearLabel: UILabel!
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    override func viewDidLoad() {
        
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func signMeUpButton(_ sender: Any) {
        
    }
    
}
