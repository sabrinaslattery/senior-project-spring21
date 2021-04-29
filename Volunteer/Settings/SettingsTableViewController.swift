//
//  SettingsViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 4/20/21.
//

import UIKit
import Parse

class SettingsTableViewController: UITableViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    func loadLoginScreen(){
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = storyBoard.instantiateViewController(withIdentifier:         "LoginViewController")
        self.present(viewController, animated: true, completion: nil)
    }
    
    @IBAction func logOut(_ sender: Any) {
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
