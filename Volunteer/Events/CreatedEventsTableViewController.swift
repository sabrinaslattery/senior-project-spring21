//
//  CreatedEventsTableViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 4/15/21.
//

import UIKit
import Parse
import SideMenu

class CreatedEventsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MenuControllerDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
    let myRefreshControl = UIRefreshControl()
    
    var Events = [PFObject]()
    var selectedEvent: PFObject!
    
    var date :NSDate?
    
    //sidebar menu vars
    private var sideMenu: SideMenuNavigationController?
    private let profileController = MainProfileViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvents()

        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.keyboardDismissMode = .interactive
        
        tableView.refreshControl = UIRefreshControl()
        tableView.refreshControl?.addTarget(self, action: #selector(loadEvents), for: .valueChanged)
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
        
        //sidebar menu integration
        let menu = SideMenuListController(with: SideMenuItem.allCases)
                
        menu.delegate = self
                    
        sideMenu = SideMenuNavigationController(rootViewController: menu)
        sideMenu?.leftSide = true
                
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
                
        addChildControllers()
    }

    @objc func loadEvents() {
        let user = PFUser.current()
        let query = PFQuery(className:"Events")
        //query.whereKey("ToEvents", equalTo: user).addAscendingOrder("date")

        query.findObjectsInBackground { (posts, error) in
            self.Events.removeAll()
            if let posts = posts {
                for post in posts {
                    self.Events.append(post)
                }
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let post = posts[section]
        
        return self.Events.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = Events[indexPath.row]
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "CreatedEventsCell", for: indexPath) as! CreatedEventsTableViewCell
        
        
        //Setting name and tag
        cell.eventName.text = event["title"] as? String
        cell.eventTags.text = event["tag"] as? String
        
        //Setting the date/time of the event
        let date = event["date"] as! Date
        let formatter = DateFormatter()
        let eventDate = formatter.string(from: date)
        cell.eventDate.date = date
        
        //Setting the event's image
        
        let parseImage = event["image"] as! PFFileObject
        parseImage.getDataInBackground { (imageData, error) in
            if let error = error {
                print(error.localizedDescription)
            } else if let imageData = imageData {
                let image = UIImage(data: imageData)
                cell.eventImage.image = image
            }
        }
        
        //Setting the difficulty image
        let difficulty = event["difficulty"] as! String
        switch difficulty.lowercased() {
        case "easy":
            cell.difficultyImage.image = UIImage(named: "Difficulty_Easy")
        case "medium":
            cell.difficultyImage.image = UIImage(named: "Difficulty_Medium")
        case "hard":
            cell.difficultyImage.image = UIImage(named: "Difficulty_Hard")
        default:
            break
        }
        
        return cell
    }
    
    //Pass the selected event to the details page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let event = Events[indexPath!.row]
        
        let eventDetailsViewController = segue.destination as! EventDetailsViewController
        
        eventDetailsViewController.event = event
        
    }
    //sidebar menu funcs
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