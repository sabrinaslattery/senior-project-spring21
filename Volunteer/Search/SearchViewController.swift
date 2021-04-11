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

//UITableViewDelegate

class SearchViewController: UIViewController, UITableViewDataSource,  UISearchResultsUpdating {
    
    
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
   
    var events = [PFObject]()
    var titles = [String]()
    var filteredData: [String]!
    var searchController: UISearchController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //tableView.delegate = self
        tableView.dataSource = self
        //searchBar.delegate = self
        
        // Initializing with searchResultsController set to nil means that
                // searchController will use this view controller to display the search results
                searchController = UISearchController(searchResultsController: nil)
                searchController.searchResultsUpdater = self

                // If we are using this same view controller to present the results
                // dimming it out wouldn't make sense. Should probably only set
                // this to yes if using another controller to display the search results.
                searchController.dimsBackgroundDuringPresentation = false

                searchController.searchBar.sizeToFit()
                tableView.tableHeaderView = searchController.searchBar

                // Sets this view controller as presenting view controller for the search interface
                definesPresentationContext = true
        
        filteredData = titles
        // Do any additional setup after loading the view.
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
           
        let query = PFQuery(className: "Events")
        query.includeKey("title")
           query.limit = 100
           
        query.findObjectsInBackground { (events, error) in
            self.events.removeAll()
            self.titles.removeAll()
            if let events = events {
                for event in events {
                    self.events.append(event)
                    print(events)
                    self.titles.append(event["title"] as! String)
                    print(self.titles)
                    self.tableView.reloadData()
                }
            } else if let error = error {
                    print(error.localizedDescription)
                }
                   
               }
           }
       
    
    
    // MARK: - Table view data source
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //let event = events[section]
        
        //?? operator gives PFObject a default value, in this case "[]"
        //let eventData = (event["title"] as? [PFObject]) ?? []
        
        //adds the other two table view cells
        
        return filteredData.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1 //events.count
      }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let event = self.events[indexPath.row]
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchEventCell", for: indexPath) as! SearchEventCell
                
        
        cell.eventTitleLabel.text = event["title"] as! String
            
        
        return cell
 
    }
    
    func updateSearchResults(for searchController: UISearchController) {
           if let searchText = searchController.searchBar.text {
            filteredData = titles.isEmpty ? titles : titles.filter({(dataString: String) -> Bool in
                  // return dataString.rangeOfString(searchText, options: .CaseInsensitiveSearch) != nil
                return dataString.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
               })
            
               tableView.reloadData()
           }
        
        
        
    
    // This method updates filteredData based on the text in the Search Box;
    //search method does not work yet
   
    //func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        // When there is no text, filteredData is the same as the original data
        // When user has entered text into the search box
        // Use the filter method to iterate over all items in the data array
        // For each item, return true if the item should be included and false if the
        // item should NOT be included
        
        
        
       
        

        //self.filteredData = searchText.isEmpty ? titles : titles.filter { (item: String) -> Bool in
            // If dataItem matches the searchText, return true to include it
           // return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
       // }
        
       // tableView.reloadData()
    
   // }
    

         
    }
}
