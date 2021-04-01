//
//  SearchViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/23/21.
//

import UIKit

class SearchViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {
    
    

    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet var tableView: UITableView!
    
    //dummy data; will replace soon
    let data = ["New York, NY", "Los Angeles, CA", "Chicago, IL", "Houston, TX",
            "Philadelphia, PA", "Phoenix, AZ", "San Diego, CA", "San Antonio, TX",
            "Dallas, TX", "Detroit, MI", "San Jose, CA", "Indianapolis, IN",
            "Jacksonville, FL", "San Francisco, CA", "Columbus, OH", "Austin, TX",
            "Memphis, TN", "Baltimore, MD", "Charlotte, ND", "Fort Worth, TX"]

        var filteredData: [String]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        searchBar.delegate = self
        
        filteredData = data
        // Do any additional setup after loading the view.
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredData.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "datacell", for: indexPath) as! UITableViewCell
                cell.textLabel?.text = filteredData[indexPath.item]
                return cell
    }
    
    // This method updates filteredData based on the text in the Search Box
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
          
          tableView.reloadData()
      }
}
