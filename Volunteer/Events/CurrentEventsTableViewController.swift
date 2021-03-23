//
//  CurrentEventsTableViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/22/21.
//

import UIKit

class CurrentEventsTableViewController: UITableViewController {

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
        //will load all available events from database
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
}
