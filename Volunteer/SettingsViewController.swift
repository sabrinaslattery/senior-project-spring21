//
//  SettingsViewController.swift
//  Volunteer
//
//  Created by Roberto on 3/28/21.
//

import UIKit
import SideMenu
import Parse

class SettingsViewController: UIViewController, MenuControllerDelegate {
    private var sideMenu: SideMenuNavigationController?
   
    private let profileController = MainProfileViewController()
    
    // Button Functionality
    @IBAction func gotoPhoneButton(_ sender: Any) {
    }
    
    @IBAction func changePasswordButton(_ sender: Any) {
    }
    
    @IBAction func twoFactAuthButton(_ sender: Any) {
    }
    
    @IBAction func notificationButton(_ sender: Any) {
    }
    
    @IBAction func accessibilityButton(_ sender: Any) {
    }
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
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

}
