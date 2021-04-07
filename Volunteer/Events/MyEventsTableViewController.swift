//
//  PreviousEventsTableViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/23/21.
//

import UIKit
import Parse

class MyEventsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var tableView: UITableView!
        
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
    }
        
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
            loadEvents()
    }
        
    @objc func loadEvents() {
            
        let user = PFUser.current()
        let query = PFQuery(className:"Events")
        query.whereKey("attendees", equalTo: user)
        //query.includeKey("attendees")
           
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
        //self.tableView.reloadData()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Events.count
    }
        
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
        
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = Events[indexPath.row] 
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "MyEventsCell", for: indexPath) as! MyEventsTableViewCell
        
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
            
        switch event["difficulty"] as! String {
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
        
        let eventViewController = segue.destination as! EventDetailsViewController
            
        eventViewController.event = event

    }
}
