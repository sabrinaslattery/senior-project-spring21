//
//  CurrentEventsTableViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/23/21.
//

import Foundation
import UIKit
import Parse
import AlamofireImage

class AllEventsTableViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

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
    
	//Pass the selected event to the details page
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
        let cell = sender as! UITableViewCell
		let indexPath = tableView.indexPath(for: cell)
		let event = Events[indexPath!.row]
        
        let eventDetailsViewController = segue.destination as! EventDetailsViewController
		
        eventDetailsViewController.event = event
	}

}
//extension AllEventsTableViewController: UISearchBarDelegate  {
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(true)
//        let query = PFQuery(className: "Events")
//        query.includeKey("title")
//        query.limit = 100
//
//        query.findObjectsInBackground { (events, error) in
//            self.events.removeAll()
//            self.titles.removeAll()
//            if let events = events {
//                for event in events {
//                    self.events.append(event)
//                    print(events)
//                    self.titles.append(event["title"] as! String)
//                    print(self.titles)
//                    self.tableView.reloadData()
//                }
//            } else if let error = error {
//                    print(error.localizedDescription)
//            }
//        }
//    }
//
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchEventCell", for: indexPath) as! SearchEventCell
//        cell.textLabel?.text = filteredData[indexPath.row]
//        return cell
//    }
//
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return self.filteredData.count
//    }
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//         filteredData = searchText.isEmpty ? titles : titles.filter { (item: String) -> Bool in
//             return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
//         }
//         tableView.reloadData()
//    }
//
//    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
//         self.searchBar.showsCancelButton = true
//    }
//
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//         searchBar.showsCancelButton = false
//         searchBar.text = ""
//         searchBar.resignFirstResponder()
//    }
//}
