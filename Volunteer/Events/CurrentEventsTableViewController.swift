//
//  CurrentEventsTableViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/23/21.
//

import UIKit
import Parse

class CurrentEventsTableViewController: UITableViewController {

    //var eventsArray = [NSDictionary]()
       
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
           
           myRefreshControl.addTarget(self, action: #selector(loadEvents), for: .valueChanged)
           tableView.refreshControl = myRefreshControl
           
           tableView.rowHeight = UITableView.automaticDimension
           tableView.estimatedRowHeight = 150
           
           
       }
       
       @objc func loadEvents() {
           
       }

       override func numberOfSections(in tableView: UITableView) -> Int {
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
           query.includeKeys(["eventName", "eventDate", "eventTag", "eventDiff"])
           query.limit = 20
           
           query.findObjectsInBackground { (posts, error) in
               if posts != nil {
                   self.Events = posts!
                   self.tableView.reloadData()
                   self.myRefreshControl.endRefreshing()
               }
           }
       }
       
       override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let event = Events[indexPath.section]
           
           if indexPath.row == 0 {
               let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentEventsTableViewCell") as! CurrentEventsTableViewCell
           
               let post = event["eventName"] as! PFUser
               cell.eventName.text = post["eventName"] as? String
           
           
               let imageFile = event["eventImage"] as! PFFileObject
               let urlString = imageFile.url!
               let url = URL(string: urlString)!
           
               cell.eventImage.af.setImage(withURL: url)
               
               let dateOnPicker = cell.eventDate.date
               let dateFormatter = DateFormatter()
               
               dateFormatter.dateStyle = DateFormatter.Style.short
               let timeAsString = dateFormatter.string(from: dateOnPicker)
               UserDefaults.standard.set(timeAsString, forKey: "eventDate")
               
               let diffPicker = cell.eventDifficulty
               PFUser.current()?["eventDiff"] = diffPicker
               PFUser.current()?.saveInBackground()
               
               let tagPicker = cell.eventTags
               PFUser.current()?["eventTag"] = tagPicker
               PFUser.current()?.saveInBackground()
               
               return cell
           } else {
               let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentEventsTableViewCell")!
               return cell
           }
           
       }
       
   }
