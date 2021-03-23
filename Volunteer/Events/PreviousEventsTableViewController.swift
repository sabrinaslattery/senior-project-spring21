//
//  PreviousEventsTableViewController.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/22/21.
//

import UIKit

class PreviousEventsTableViewController: UITableViewController {

    let myRefreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPrevEvents()
        
        myRefreshControl.addTarget(self, action: #selector(loadPrevEvents), for: .valueChanged)
        tableView.refreshControl = myRefreshControl
        
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 150
       
    }

    @objc func loadPrevEvents() {
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //returns number of rows - replace with eventsArray.count
        return 5
    }

}
