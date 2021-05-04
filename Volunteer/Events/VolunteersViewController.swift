//
//  VolunteersViewController.swift
//  Volunteer
//
//  Created by Karina Naranjo on 4/24/21.
//

import UIKit
import Parse

class VolunteersViewController: UIViewController, UITableViewDelegate,
                                UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return volunteers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        let cell = tableView.dequeueReusableCell(withIdentifier: "volunteerCell") as! VolunteerInfoTableViewCell
        
        
        let volunteerPost = volunteers[indexPath.row]
        cell.volunteerName.text = volunteers[0] as? String
//        cell.VolunteerEmail.text = volunteers[1] as? String
        
        return cell
    }
    
    
    @IBOutlet weak var volunteerTableView: UITableView!
    var volunteers = [Any]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        volunteerTableView.delegate = self
        volunteerTableView.dataSource = self
        
        volunteerTableView.rowHeight = 75
        volunteerTableView.estimatedRowHeight = 600
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        //let objectidvalue = Events("objectId")
        //let user = PFUser.current()
        let query = PFQuery(className: "Events")
        
        query.whereKey("objectId", equalTo: "AkBi9m3TiY")
        query.selectKeys(["attendees"])
        
        query.findObjectsInBackground { (volunteer, error: Error?) -> Void in
            if volunteer != nil {
                print("found something:", volunteer as Any)
//                print(volunteer["attendees"] as! String)
                print(type(of: volunteer))
                self.volunteers = volunteer!
                self.volunteerTableView.reloadData()
                
            }
        }
    }

        
        @IBAction func handleDismissButton(_ sender: Any) {
            self.dismiss(animated: false, completion: nil)
        }
}

    


