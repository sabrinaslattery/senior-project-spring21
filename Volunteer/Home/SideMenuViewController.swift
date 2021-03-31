//
//  SideMenuViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/28/21.
//
import UIKit
import Parse
import SideMenu

class SideMenuViewController: UISearchController, MenuControllerDelegateTest, MenuControllerDelegate {
  
    private var sideMenu: SideMenuNavigationController?
    private let profileController = MainProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let menu = MenuListController(with: ["UserName", "Home", "My Profile", "Events", "Create An Event", "Search", "Settings", "", "Sign Out"])
        menu.delegate = self
        let sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu.leftSide = true
        
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
        
        addChildControllers()

    }
    
    private func addChildControllers() {
        addChild(profileController)
        view.addSubview(profileController.view)
        profileController.view.frame = view.bounds
        profileController.didMove(toParent: self)
        
        profileController.view.isHidden = true
    }
    
    @IBAction func didTapMenu() {
        present(sideMenu!, animated: true)
    }
    
    func didSelectMenuItem(named: String) {
        sideMenu?.dismiss(animated: true, completion: {
            
            self.title = named
            
            if named == "UserName" {
                
            }
            else if named == "My Profile" {
                self.profileController.view.isHidden = false
            }
            else if named == "Events" {
                
            }
            else if named == "Create An Event" {
                
            }
            else if named == "Search" {
                
            }
            else if named == "Settings" {
                
            }
            else if named == "Sign Out" {
                
            }
        })
    }
}

protocol MenuControllerDelegateTest {
    func didSelectMenuItem(named: String)
}

class MenuListController: UITableViewController {
    
    var delegate: MenuControllerDelegate?
    private let menuItems: [String]
    
    let sideBarColor = UIColor(red: 75/225.0, green: 75/225.0, blue: 75/225.0, alpha: 1)
    
    init(with menuItems: [String]) {
        self.menuItems = menuItems
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = sideBarColor
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        view.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = menuItems[indexPath.row]
        cell.textLabel?.textColor = .white
        cell.backgroundColor = sideBarColor
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let selectedItem = menuItems[indexPath.row]
        delegate?.didSelectMenuItem(named: SideMenuItem(rawValue: selectedItem))
    }
}
