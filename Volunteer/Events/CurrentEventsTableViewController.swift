//
//  CurrentEventsTableViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/23/21.
//

import UIKit

class CurrentEventsTableViewController: UITableViewController {

    var eventsArray = [NSDictionary]()
    
    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadEvents()
        
        myRefreshControl.addTarget(self, action: #selector(loadEvents), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
    }

    @objc func loadEvents() {
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        //replace with eventsArray.count
        return 5
    }

}
