//
//  CreatedEventsTableViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 4/15/21.
//

import UIKit
import Parse

class CreatedEventsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    @IBOutlet weak var tableView: UITableView!
    
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
    }

    @objc func loadEvents() {
        let user = PFUser.current()
        let query = PFQuery(className:"Events")
        //work on this line of code
        //want to retun only events created by user
        //query.whereKey("createdBy", equalTo: user?["objectId"]).addAscendingOrder("date")
        query.whereKey("date", greaterThanOrEqualTo: Date()).addAscendingOrder("date")
        
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
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let post = posts[section]
        
        return self.Events.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let event = Events[indexPath.row]
        
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "OrganizerEventsCell", for: indexPath) as! CreatedEventsTableViewCell
        
        
        //Setting name and tag
        cell.eventName.text = event["title"] as? String
        cell.eventTags.text = event["tag"] as? String
        
        //Setting the date/time of the event
        let date = event["date"] as! Date
//        let formatter = DateFormatter()
//        let eventDate = formatter.string(from: date)
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
        
        let CreatorEventDetailsViewController = segue.destination as! CreatorEventDetailsViewController
        
        CreatorEventDetailsViewController.event = event
    }
}
