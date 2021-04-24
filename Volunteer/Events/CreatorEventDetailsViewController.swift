//
//  CreatorEventDetailsViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 4/15/21.
//

import Foundation
import UIKit
import Parse

class CreatorEventDetailsViewController: UIViewController {

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
    
    var event = PFObject(className: "Events")
    
    override func viewDidLoad() {
        print(event)
        
        //Load data passed from segue into fields
        eventTitleLabel.text = (event["title"] as! String)
        //Load image
        let parseImage = event["image"] as! PFFileObject
        parseImage.getDataInBackground { (imageData, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let imageData = imageData {
                let image = UIImage(data: imageData)
                self.eventImage.image = image
            }
        }
        
        //Setting the difficulty image
        let difficulty =  event["difficulty"] as! String
        switch difficulty.lowercased() {
        case "easy":
            difficultyImage.image = UIImage(named: "Difficulty_Easy")
        case "medium":
            difficultyImage.image = UIImage(named: "Difficulty_Medium")
        case "hard":
            difficultyImage.image = UIImage(named: "Difficulty_Hard")
        default:
            break
        }
        
        //Setting the date
        let date = event["date"] as! Date
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        eventDateLabel.text = formatter.string(from: date)
        print(formatter.string(from: date))
        
        //Set spots filled
        let attendees = event.object(forKey: "attendees") as! NSArray
        let totalSpots = event["totalSpots"] as! Int
        spotsFilledLabel.text =  "\(attendees.count)/\(totalSpots)"
        //Set time from and time to
        let dateFrom = event["startTime"] as! Date
        let dateTo = event["endTime"] as! Date
        formatter.dateStyle = .none
        formatter.timeStyle = .short
        dateFromLabel.text = formatter.string(from: dateFrom)
        dateToLabel.text = formatter.string(from: dateTo)
        
        //Set "About This Event", "Volunteers expectations", and appropriate clothing
        aboutEventLabel.text = (event["description"] as! String)
        eventExpectationLabel.text = (event["expectations"] as! String)
        shouldWearLabel.text = (event["clothes"] as! String)
        
        //Set contact email and phone
        contactEmailLabel.text = (event["contactEmail"] as! String)
        phoneNumberLabel.text = (event["contactPhone"] as! String)
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
}
