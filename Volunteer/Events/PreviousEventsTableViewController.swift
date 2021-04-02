//
//  PreviousEventsTableViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/23/21.
//

import UIKit
import Parse

class PreviousEventsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
    //var eventsArray = [NSDictionary]()
    
    let myRefreshControl = UIRefreshControl()
    
    var Events = [PFObject]()
    var selectedEvent: PFObject!
    
    var date :NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //loadEvents()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.keyboardDismissMode = .interactive
        
       // myRefreshControl.addTarget(self, action: #selector(loadEvents), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
    }
    
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        self.loadEvents()
//    }
    
    @objc func loadEvents() {
        
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return Events.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return Events.count
    }

    /*override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let post = posts[section]
        
        return 3
    }*/
    
    override func viewDidAppear(_ animated: Bool) {
        //numberOfPosts = 20
        super.viewDidAppear(true)
        
        let query = PFQuery(className:"Events")
        query.whereKey("date", lessThan: Date())
        query.limit = 20
        
		query.findObjectsInBackground { (posts, error) in
			if let posts = posts {
				for post in posts {
					if self.Events.contains(post) != true {
						self.Events.append(post)
					}
				}
				self.tableView.reloadData()
				self.myRefreshControl.endRefreshing()
				print(self.Events)
			}
		}
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let event = Events[indexPath.section] as! PFObject
		
		let cell = self.tableView.dequeueReusableCell(withIdentifier: "PreviousEventsCell", for: indexPath) as! PreviousEventsTableViewCell
		
		cell.eventName.text = event["title"] as! String
		cell.eventTags.text = event["tag"] as! String
		
		//Setting the date/time of the event
		let date = event["date"] as! Date
		let formatter = DateFormatter()
		let eventDate = formatter.string(from: date) as! String
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
		/*
		switch event["difficulty"] as! String {
		case "easy":
			cell.difficultyImage.image = UIImage(named: "Difficulty_Easy")
		case "medium":
			cell.difficultyImage.image = UIImage(named: "Difficulty_Medium")
		case "hard":
			cell.difficultyImage.image = UIImage(named: "Difficulty_Hard")
		default:
			break
		} */
		
		
		
		return cell
    }
    
}
