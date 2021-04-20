//
//  CurrentEventsTableViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/23/21.
//

import UIKit
import Parse
import SideMenu

class AllEventsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, MenuControllerDelegate  {

	@IBOutlet weak var tableView: UITableView!
    
    private var sideMenu: SideMenuNavigationController?
       
    private let profileController = MainProfileViewController()
	
	let myRefreshControl = UIRefreshControl()
	
	var Events = [PFObject]()
	var selectedEvent: PFObject!
	
	var date :NSDate?
	
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
        
        let menu = SideMenuListController(with: SideMenuItem.allCases)
                
        menu.delegate = self
                    
        sideMenu = SideMenuNavigationController(rootViewController: menu)
                    sideMenu?.leftSide = true
                
        SideMenuManager.default.leftMenuNavigationController = sideMenu
        SideMenuManager.default.addPanGestureToPresent(toView: view)
                
        addChildControllers()
	}
    
    private func addChildControllers(){
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
                performSegue(withIdentifier: "eventToProfileSegue", sender: nil)
            
            case .home:
                performSegue(withIdentifier: "eventToHomeSegue", sender: nil)
                    
            case .profile:
                performSegue(withIdentifier: "eventToProfileSegue", sender: nil)
                
            case .events:
                performSegue(withIdentifier: "eventToEventsSegue", sender: nil)
                    
            case .create:
                performSegue(withIdentifier: "eventToCreateSegue", sender: nil)
                    
            case .search:
                performSegue(withIdentifier: "eventToSearchSegue", sender: nil)
                    
            case .settings:
                performSegue(withIdentifier: "eventToSettingsSegue", sender: nil)
        
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
    
	@objc func loadEvents() {
		let query = PFQuery(className:"Events")
        query.whereKey("date", greaterThan: Date()).addAscendingOrder("date")
		//query.includeKeys(["eventName", "eventDate", "eventTag", "eventDiff"])
		query.limit = 20
		
		query.findObjectsInBackground { (events, error) in
			if let error = error {
				print(error.localizedDescription)
			} else if let events = events {
				self.Events.removeAll()
				for event in events {
					self.Events.append(event)
				}
			}
			self.tableView.reloadData()
			self.tableView.refreshControl?.endRefreshing()
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
		
		let cell = self.tableView.dequeueReusableCell(withIdentifier: "AllEventsCell", for: indexPath) as! AllEventsTableViewCell
		
		
		//Setting name and tag
		cell.eventName.text = event["title"] as! String
		cell.eventTags.text = event["tag"] as! String
		
		//Setting the date/time of the event
		let date = event["date"] as! Date
		let formatter = DateFormatter()
        _ = formatter.string(from: date)
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
	
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
	//Pass the selected event to the details page
	override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
        let cell = sender as! UITableViewCell
		let indexPath = tableView.indexPath(for: cell)
		let event = Events[indexPath!.row]
		
		let eventDetailsViewController = segue.destination as! EventDetailsViewController
		
		eventDetailsViewController.event = event
		
	}
	
}
