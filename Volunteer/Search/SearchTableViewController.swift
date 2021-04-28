//
//  SearchTableViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/23/21.
//

import Foundation
import UIKit
import Parse
import AlamofireImage

class SearchTableViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var searchTableView: UITableView!
    
    var events = [PFObject]()
    var titles = [String]()
        
    var filteredData: [String]!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        searchBar.delegate = self
        filteredData = titles
    }

    override func viewDidAppear(_ animated: Bool) {
        // super.viewDidAppear(true)
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
        
    @IBAction func backToHome(_ sender: Any) {
        //screen dismisses itself
                self.dismiss(animated: true, completion: nil)
    }
    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchEventCell", for: indexPath) as! SearchEventCell
        cell.textLabel?.text = filteredData[indexPath.row]
        return cell
    }
        
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.filteredData.count
    }
        
//MARK: - Search Functions
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
            filteredData = searchText.isEmpty ? titles : titles.filter { (item: String) -> Bool in
                return item.range(of: searchText, options: .caseInsensitive, range: nil, locale: nil) != nil
            }
            tableView.reloadData()
    }
        
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
            self.searchBar.showsCancelButton = true
    }
        
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searchBar.showsCancelButton = false
            searchBar.text = ""
            searchBar.resignFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let cell = sender as! UITableViewCell
        let indexPath = tableView.indexPath(for: cell)
        let event = events[indexPath!.row]
        
        let eventDetailsViewController = segue.destination as! EventDetailsViewController
        
        eventDetailsViewController.event = event
    }
    
}
