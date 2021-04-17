//
//  MainProfileViewController.swift
//  Volunteer
//
//  Created by Joshua Freedman, Jessica Alvarez on 3/30/21.
//

import Foundation
import UIKit
import Parse
import AlamofireImage
import SideMenu

class MainProfileViewController: UIViewController, MenuControllerDelegate {
    private var sideMenu: SideMenuNavigationController?
   
    private let profileController = MainProfileViewController()
    
            @IBOutlet var firstName: UILabel?
            @IBOutlet var lastName: UILabel?
            @IBOutlet var profileImage: UIImageView!
            @IBOutlet var city: UILabel?
            @IBOutlet var zipCode: UILabel?
            @IBOutlet var jobTitle: UILabel?
            @IBOutlet var emailAddress: UILabel?
            //@IBOutlet var phoneNumber: UILabel?
            @IBOutlet var intro: UILabel?
            @IBOutlet var educationLevel: UILabel?
            @IBOutlet var workExperience: UILabel?
            //@IBOutlet var interests: UILabel?


            override func viewDidLoad() {
                super.viewDidLoad()
                showFirstName()
                showLastName()
                showProfileImage()
                showCity()
                showZipCode()
                showJobTitle()
                showEmail()
//                showPhoneNumber()
                showIntro()
                showEducationLevel()
                showWorkExperience()
//                showInterests()
                
                let menu = SideMenuListController(with: SideMenuItem.allCases)
            
                menu.delegate = self
                
                   sideMenu = SideMenuNavigationController(rootViewController: menu)
                sideMenu?.leftSide = true
            
                SideMenuManager.default.leftMenuNavigationController = sideMenu
                SideMenuManager.default.addPanGestureToPresent(toView: view)
            
                addChildControllers()
                // Do any additional setup after loading the view.
                
                
            
            }
    
    private func addChildControllers() {
        addChild(profileController)
        //add more children
    
        view.addSubview(profileController.view)
    
        profileController.view.frame = view.bounds
        profileController.didMove(toParent: self)
        profileController.view.isHidden = true
    }
    
    // attach menu button to this function
    @IBAction func didTapMenu() {
        present(sideMenu!, animated: true)
    }
    
    func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier:         "LoginViewController")
        self.present(viewController, animated: true, completion: nil)
    }
    
    func didSelectMenuItem(named: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: nil)
        
        title = named.rawValue
        switch named {
               case .user:
                performSegue(withIdentifier: "profileSegue", sender: nil)
    
                case .home:
                performSegue(withIdentifier: "homeSegue", sender: nil)
            
                case .profile:
                performSegue(withIdentifier: "profileSegue", sender: nil)
            
                case .events:
                performSegue(withIdentifier: "eventsSegue", sender: nil)
            
                case .create:
                performSegue(withIdentifier: "createSegue", sender: nil)
            
                case .search:
                performSegue(withIdentifier: "searchSegue", sender: nil)
            
                case .settings:
                performSegue(withIdentifier: "settingsSegue", sender: nil)
            
                case .logOut:
                PFUser.logOutInBackground { (error: Error?) in
                        if (error == nil){
                            self.loadLoginScreen()
                        }else{
                               let alert = UIAlertController(title: "Error Logging Out", message: error?.localizedDescription, preferredStyle: .alert)
                   alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: { (action) in
                       print(error.debugDescription)
                   }))
                   self.present(alert, animated: true)
               }

           }
            loadLoginScreen()
        }
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
            
                func showProfileImage () {
                                let query = PFQuery(className: "Profile")
                                query.whereKey("user", equalTo:  PFUser.current()!)
                                query.includeKey("image")
                                query.findObjectsInBackground { (result: [PFObject]!, error: Error?) in
                                if let result = result {
                                    for list in result{

                                        let output:PFFileObject = list["image"] as! PFFileObject
                                        output.getDataInBackground { (ImageData: Data?, error: Error?) in
                                            if error == nil {

                                                let Image: UIImage = UIImage (data: ImageData!)!
                                                self.profileImage?.image = Image
                                            }
                                        }
                //                        let output = list["image"] as? PFFileObject
                //                        self.profileImage.image!.pngData() = output

                                      }
                                   }
                                }
                            }
                
                func showCity () {
                    let query = PFQuery(className: "Profile")
                    query.whereKey("user", equalTo:  PFUser.current()!)
                    query.includeKey("city")
                    query.findObjectsInBackground { (result: [PFObject]!, error: Error?) in
                        if let result = result {
                            for list in result{

                                let output = list["city"] as? String
                                self.city?.text = output

                                print(output as Any)
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

                                print(output as Any)
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

                            print(output as Any)
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

                            print(output as Any)
                        }

                    }

                    }
            }
    
    func showEducationLevel () {
            let query = PFQuery(className: "Profile")
            query.whereKey("user", equalTo: PFUser.current()!)
            query.includeKey("educationLevel")
            query.findObjectsInBackground { (result: [PFObject]!, error: Error?) in
              if let result = result {
                for list in result{
                  let output = list["educationLevel"] as? String
                  self.educationLevel?.text = output
                  print(output as Any)
                }
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

                            print(output as Any)
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
