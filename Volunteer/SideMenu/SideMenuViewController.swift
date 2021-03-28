//
//  SideMenuViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/28/21.
//

import UIKit
import Parse
import SideMenu

class SideMenuViewController: UISearchController {

    var menu: SideMenuNavigationController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        menu = SideMenuNavigationController(rootViewController: UIViewController())
        menu?.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = menu
        SideMenuManager.default.addPanGestureToPresent(toView: self.view)

    }
    
    @IBAction func didTapMenu() {
        present(menu!, animated: true)
    }
}


class MenuListController: UITableViewController {
    
    var itemsArray = ["User's Name", "", "Home", "My Profile", "Events", "Create an Event", "Search", "Settings", "", "Sign Out"]
    
    let sideBarColor = UIColor(red: 75/225.0, green: 75/225.0, blue: 75/225.0, alpha: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = sideBarColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = itemsArray[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = sideBarColor
        
        return cell
    }
}
