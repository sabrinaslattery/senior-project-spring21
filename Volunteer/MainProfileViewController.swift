//
//  MainProfileViewController.swift
//  Volunteer
//
//  Created by Joshua Freedman, Jessica Alvarez on 3/30/21.
//

import Foundation
import UIKit
import Parse

class MainProfileViewController: UIViewController {
    

            @IBOutlet var firstName: UILabel?
            @IBOutlet var lastName: UILabel?
            @IBOutlet var profileImage: UIImageView!
            @IBOutlet var city: UILabel?
            @IBOutlet var zipCode: UILabel?
            @IBOutlet var jobTitle: UILabel?
            @IBOutlet var emailAddress: UILabel?
            @IBOutlet var phoneNumber: UILabel?
            @IBOutlet var intro: UILabel?
            @IBOutlet var educationLevel: UILabel?
            @IBOutlet var workExperience: UILabel?
            @IBOutlet var interests: UILabel?
            
            override func viewDidLoad() {
                super.viewDidLoad()
                showFirstName()
                showLastName()
//                showProfileImage()
                showCity()
                showZipCode()
                showJobTitle()
                showEmail()
//                showPhoneNumber()
                showIntro()
//                showEducationLevel()
                showWorkExperience()
//                showInterests()
                // Do any additional setup after loading the view.
            
            }
            
    
            func showFirstName() {
                let userFirstName = PFUser.current()?.object(forKey: "firstname") as! String
                self.firstName?.text = userFirstName
                print(userFirstName)
            }
                func showLastName() {
                    let userLastName = PFUser.current()?.object(forKey: "lastname") as! String
                    self.lastName?.text =  userLastName
                    print(userLastName)
            }
            
//                func showProfileImage() {
//                    let profileImageQuery = PFQuery(className:"Profile")
//                    profileImageQuery.whereKey("profileImage", equalTo: PFUser.current() as Any)
//                    profileImageQuery.getObjectInBackground(withId: "profileImage") { (result:PFObject?, error: Error?) in
//                        if let userProfileImage = result
//                        {
//                            self.profileImage.image = userProfileImage ["profileImage"] as? UIImage
//                            print(userProfileImage)
//                        }
//                    }
//                }
        
   // @IBAction func backButton(_ sender: Any) {
           // dismiss(animated: true, completion: nil)
        //}
    
    
    
    func showCity () {
        let query = PFQuery(className: "Profile")
        query.whereKey("user", equalTo:  PFUser.current()!)
        query.includeKey("city")
        query.findObjectsInBackground { (result: [PFObject]!, error: Error?) in
            if let result = result {
                for list in result{

                    let output = list["city"] as? String
                    self.city?.text = output


                    print(output!)
                }

            }

            }
    }
                func showZipCode () {
                    let query = PFQuery(className: "Profile")
                    query.whereKey("user", equalTo:  PFUser.current()!)
                    query.includeKey("zipCode")
                    query.findObjectsInBackground { (result: [PFObject]!, error: Error?) in
                        if let result = result {
                            for list in result{

                                let output = list["zipCode"] as? String
                                self.zipCode?.text = output

                                print(output!)
                            }

                        }

                        }
                }


            func showJobTitle () {
                let query = PFQuery(className: "Profile")
                query.whereKey("user", equalTo:  PFUser.current()!)
                query.includeKey("jobTitle")
                query.findObjectsInBackground { (result: [PFObject]!, error: Error?) in
                    if let result = result {
                        for list in result{

                            let output = list["jobTitle"] as? String
                            self.jobTitle?.text = output

                            print(output!)
                        }

                    }

                    }
            }

            func showEmail () {
                let userEmail = PFUser.current()?.object(forKey: "email") as! String
                self.emailAddress?.text = userEmail
                print(userEmail)

            }
            
//            func showPhoneNumber() {
//                let query = PFQuery(className: "Profile")
//                query.whereKey("user", equalTo:  PFUser.current()!)
//                query.includeKey("phonenumber")
//                query.findObjectsInBackground { (result: [PFObject]!, error: Error?) in
//                    if let result = result {
//                        for list in result{
//
//                            let output = list["phonenumber"] as? String
//                            self.phoneNumber?.text = output
//
//                            print(output!)
//                        }
//
//                    }
//
//                    }
//            }
//
    
            func showIntro () {
                let query = PFQuery(className: "Profile")
                query.whereKey("user", equalTo:  PFUser.current()!)
                query.includeKey("userBio")
                query.findObjectsInBackground { (result: [PFObject]!, error: Error?) in
                    if let result = result {
                        for list in result{

                            let output = list["userBio"] as? String
                            self.intro?.text = output

                            print(output!)
                        }

                    }

                    }
            }
    
            func showEducationLevel () {
                let eduLvlQuery = PFQuery(className:"Profile")
                eduLvlQuery.whereKey("educationLevel", equalTo: PFUser.current() as Any)
                eduLvlQuery.getObjectInBackground(withId: "educationLevel") { (result: PFObject?, error: Error?) in
                    if let userEducationLevel = result
                    {
                        self.educationLevel?.text = userEducationLevel ["educationLevel"] as? String
                        print(userEducationLevel)
                    }
                }
            }

            func showWorkExperience () {
                let query = PFQuery(className: "Profile")
                query.whereKey("user", equalTo:  PFUser.current()!)
                query.includeKey("workExperience")
                query.findObjectsInBackground { (result: [PFObject]!, error: Error?) in
                    if let result = result {
                        for list in result{

                            let output = list["workExperience"] as? String
                            self.workExperience?.text = output

                            print(output!)
                        }

                    }

                    }
            }
//
//            func showInterests () {
//                let interestsQuery = PFQuery(className:"Profile")
//                interestsQuery.whereKey("interests", equalTo: PFUser.current() as Any)
//                interestsQuery.getObjectInBackground(withId: "interests") { (result: PFObject?, error: Error?) in
//                    if let userInterests = result
//                    {
//                        self.workExperience?.text = userInterests ["interests"] as? String
//                        print(userInterests)
//
//                    }
//                }
//            }

}
