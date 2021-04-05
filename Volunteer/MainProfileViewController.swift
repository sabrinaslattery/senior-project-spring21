//
//  MainProfileViewController.swift
//  Volunteer
//
//  Created by Joshua Freedman on 3/30/21.
//

import Foundation
import UIKit
import Parse

class MainProfileViewController: UIViewController {
    
            @IBOutlet var firstName: UILabel?
            @IBOutlet var lastName: UILabel?
            @IBOutlet var profileImage: UIImageView!
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
                showProfileImage()
                showZipCode()
                showJobTitle()
                showEmail()
//                showPhoneNumber()
                showIntro()
                showEducationLevel()
                showWorkExperience()
                showInterests()
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
            
                func showProfileImage() {
                    let profileImageQuery = PFQuery(className:"Profile")
                    profileImageQuery.whereKey("profileImage", equalTo: PFUser.current() as Any)
                    profileImageQuery.getObjectInBackground(withId: "profileImage") { (result:PFObject?, error: Error?) in
                        if let userProfileImage = result
                        {
                            self.profileImage.image = userProfileImage ["profileImage"] as? UIImage
                            print(userProfileImage)
                        }
                    }
                }
                    
            func showZipCode () {
                let query = PFQuery(className: "Profile")
                query.whereKey("zipCode", equalTo: PFUser.current()!)
                          query.findObjectsInBackground { (namelist: [PFObject]?, error: Error?) in
                    if let namelist = namelist {
                    for list in namelist{
                        let output = list["zipCode"] as? String
                        self.zipCode?.text = output
                        print(output!)
                        }



                    }
            }
            }

    
            func showJobTitle () {
                let jobTitleQuery = PFQuery(className:"Profile")
                jobTitleQuery.whereKey("jobTitle", equalTo: PFUser.current() as Any)
                jobTitleQuery.getObjectInBackground(withId: "jobTitle") { (result: PFObject?, error: Error?) in
                    if let userJobTitle = result
                    {
                        self.jobTitle?.text = userJobTitle ["jobTitle"] as? String
                        print(userJobTitle)

                    }
                }
            }
        
            func showEmail () {
                let userEmail = PFUser.current()?.object(forKey: "email") as! String
                self.emailAddress?.text = userEmail
                print(userEmail)

            }
            
//            func showPhoneNumber () {
//                let userPhoneNumber = PFUser.current()?.object(forKey: "phonenumber") as! String
//                self.phoneNumber.text = userPhoneNumber
//                print(usetPhoneNumber)
//            }
            
            func showIntro () {
                let introQuery = PFQuery(className:"Profile")
                introQuery.whereKey("userBio", equalTo: PFUser.current() as Any)
                introQuery.getObjectInBackground(withId: "userBio") { (result: PFObject?, error: Error?) in
                    if let userIntro = result
                    {
                        self.intro?.text = userIntro ["useBio"] as? String
                        print(userIntro)
                        
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
                let wrkExpQuery = PFQuery(className:"Profile")
                wrkExpQuery.whereKey("workExperience", equalTo: PFUser.current() as Any)
              
                
                
                
                
                
                wrkExpQuery.getObjectInBackground(withId: "workExperience") { (result: PFObject?, error: Error?) in
                    if let userWorkExperience = result
                    {
                        self.workExperience?.text = userWorkExperience ["workExperience"] as? String
                        print(userWorkExperience)
                    }
                }
            }
            
            func showInterests () {
                let interestsQuery = PFQuery(className:"Profile")
                interestsQuery.whereKey("interests", equalTo: PFUser.current() as Any)
                interestsQuery.getObjectInBackground(withId: "interests") { (result: PFObject?, error: Error?) in
                    if let userInterests = result
                    {
                        self.workExperience?.text = userInterests ["interests"] as? String
                        print(userInterests)

                    }
                }
            }
}
