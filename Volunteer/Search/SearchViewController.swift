//
//  SearchViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/23/21.
//

import Foundation
import UIKit
import Parse
import AlamofireImage



class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    //dummy data; will replace soon
    /*
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
            "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
            "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
            "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
            "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]
*/
        var events = [PFObject]()
        var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        //filteredData = data commented out for now
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           
           let query = PFQuery(className: "Events")
        query.includeKey("title")
           query.limit = 20
           
           query.findObjectsInBackground { (events, error) in
               if events != nil {
                   self.events = events!
                   self.tableView.reloadData()
               }
           }
       }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return events.count
       }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let event = events[indexPath.section]
        
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchEventCell", for: indexPath) as! SearchEventCell
                
        
            cell.eventTitleLabel.text = event["title"] as! String

        
            return cell
        }
        else {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "SearchEventCell")!
                    
                    return cell
                }
    }
    
    // This method updates filteredData based on the text in the Search Box
    /* remove comments later
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
          // When there is no text, filteredData is the same as the original data
          // When user has entered text into the search box
          // Use the filter method to iterate over all items in the data array
          // For each item, return true if the item should be included and false if the
          // item should NOT be included
          filteredData = searchText.isEmpty ? data : data.filter { (item: String) -> Bool in
              // If dataItem matches the searchText, return true to include it
              return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
          }
     */
          
         
      
}
