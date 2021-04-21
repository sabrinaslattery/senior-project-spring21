//
//  HomeViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/30/21.
//

import UIKit
import Parse
import SideMenu

protocol MenuControllerDelegate {
    func didSelectMenuItem(named: SideMenuItem)
}

enum SideMenuItem: String, CaseIterable {
    case user = ""
    case home = "Home"
    case profile = "My Profile"
    case events = "Events"
    case create = "Create an Event"
    case search = "Search"
    case settings = "Settings"
    case logOut = "Log Out"
}


class HomeViewController: UIViewController, MenuControllerDelegate {
    private var sideMenu: SideMenuNavigationController?
    
    private let profileController = MainProfileViewController()
    //add other controllers later
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = SideMenuListController(with: SideMenuItem.allCases)
        
        menu.delegate = self
        
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        addChildControllers()
    }
    
    private func addChildControllers() {
        addChild(profileController)
        //add more children
        
        view.addSubview(profileController.view)
        
        profileController.view.frame = view.bounds
        profileController.didMove(toParent: self)
        profileController.view.isHidden = true
    }
    
    @IBAction func didTapMenu() {
        present(sideMenu!, animated: true)
    }
    
    func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier: "LoginViewController")
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
