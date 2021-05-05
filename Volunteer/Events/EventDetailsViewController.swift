//
//  EventViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 4/2/21.
//
import Foundation
import UIKit
import Parse

class EventDetailsViewController:UIViewController {
    
    @IBOutlet weak var eventTitleLabel: UILabel!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var difficultyImage: UIImageView!
    @IBOutlet weak var spotsFilledLabel: UILabel!
    
    @IBOutlet weak var eventDateLabel: UILabel!
    @IBOutlet weak var dateFromLabel: UILabel!
    @IBOutlet weak var dateToLabel: UILabel!
    
    @IBOutlet weak var streetLocation: UILabel!
    @IBOutlet weak var cityLocation: UILabel!
    @IBOutlet weak var zipCodeLocation: UILabel!
    
    @IBOutlet weak var aboutEventLabel: UILabel!
    @IBOutlet weak var eventExpectationLabel: UILabel!
    @IBOutlet weak var shouldWearLabel: UILabel!
    
    @IBOutlet weak var contactEmailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var organizerName: UILabel!
    
    @IBOutlet weak var eventBorder: UILabel!
    
    var event = PFObject(className: "Events")
    
    override func viewDidLoad() {
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
        
        //set location
        streetLocation.text = (event["streetLocation"] as! String)
        cityLocation.text = (event["cityLocation"] as! String)
        zipCodeLocation.text = (event["zipCodeLocation"] as! String)
    
        //Set "About This Event", "Volunteers expectations", and appropriate clothing
        aboutEventLabel.text = (event["description"] as! String)
        eventExpectationLabel.text = (event["expectations"] as! String)
        shouldWearLabel.text = (event["clothes"] as! String)
        
        //Set contact email and phone
        organizerName.text = (event["contactName"] as! String)
        contactEmailLabel.text = (event["contactEmail"] as! String)
        phoneNumberLabel.text = (event["contactPhone"] as! String)
        
        //cosmetics
        eventBorder.layer.borderColor = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        eventBorder.layer.borderWidth = 2.0
        eventBorder.layer.cornerRadius = 5
        
//        eventImage.layer.masksToBounds = true
//        eventImage.layer.borderWidth = 1.0
    }
    
    func displaySignUpSuccessMessage (signUpSuccessMessage:String) {
        
        let myAlert = UIAlertController(title: "You're signed up!", message: signUpSuccessMessage, preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertAction.Style.default) { action in
                self.navigationController?.popViewController(animated: true)
            
            }

        myAlert.addAction(okAction)
        self.present(myAlert, animated: true, completion: nil)
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        _ = navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signMeUpButton(_ sender: Any) {
        
        let attendees = self.event["attendees"] as! NSArray
        let totalSpots = self.event["totalSpots"] as! Int
        
        if attendees.count < totalSpots {
            self.event.addUniqueObject(PFUser.current()!, forKey: "attendees")
            self.event.saveInBackground { (ok, error) in
                if ok{
                    self.displaySignUpSuccessMessage(signUpSuccessMessage: "This event has been added to your events.")
                    print("Signed up for an event")
                } else {
                    print(error?.localizedDescription)
                }
        }
        } else {
            print("Event is full")
        }
        
    }
    
}

