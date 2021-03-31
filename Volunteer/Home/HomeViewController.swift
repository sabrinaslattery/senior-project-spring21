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
    case user = "*userName*"
    case home = "Home"
    case profile = "My Profile"
    case events = "Events"
    case create = "Create an Event"
    case search = "Search"
    case settings = "Settings"
    case logOut = "Sign Out"
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
    
    func didSelectMenuItem(named: SideMenuItem) {
        sideMenu?.dismiss(animated: true, completion: nil)
            
        title = named.rawValue
        switch named {
            case .user:
                performSegue(withIdentifier: "profileSegue", sender: nil)
        
            case .home:
                performSegue(withIdentifier: "homeSegue", sender: nil)
                //remove this in the home view controller!
                
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
                performSegue(withIdentifier: "logOutSegue", sender: nil)
                //will need to add log out functionality
        }
    }
}

class SideMenuListController: UITableViewController {
    
    public var delegate: MenuControllerDelegate?
    private let menuItems: [SideMenuItem]
    private let sideBarColor = UIColor(red: 75/225.0, green: 75/225.0, blue: 75/225.0, alpha: 1)
    
    init(with menuItems: [SideMenuItem]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = sideBarColor
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = menuItems[indexPath.row].rawValue
        cell.textLabel?.textColor = .white
        cell.backgroundColor = sideBarColor
        cell.contentView.backgroundColor = sideBarColor
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: selectedItem)
    }
}
