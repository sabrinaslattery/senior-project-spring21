//
//  VolunteersTableViewController.swift
//  Volunteer
//
//  Created by William Ordaz on 4/15/21.
//

import UIKit
import Parse

class VolunteersTableViewController: UITableViewController {

    @IBOutlet weak var VolunteersTable: UITableView!
    //    var volunteer = [PFObject]()
//
//
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//
//        // Uncomment the following line to preserve selection between presentations
//        // self.clearsSelectionOnViewWillAppear = false
//
//        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
//        // self.navigationItem.rightBarButtonItem = self.editButtonItem
//    }
//
//    override func viewDidAppear(_ animated: Bool) {
//        super.viewDidAppear(animated)
//
//        let query = PFQuery(className: "Events")
//        query.includeKey("attendees")
//        query.limit = 20
//
//        query.findObjectsInBackground { (volunteer,error) in
//            if volunteer != nil {
//                self.volunteer = volunteer!
//                self.tableView.reloadData()
//            }
//        }
//
//    }
//
//    @IBAction func handleDismissButton(_ sender: Any) {
//        self.dismiss(animated: true, completion: nil)
//    }
//
//    // MARK: - Table view data source
//
//    func tableView (_tableView: UITableView, numberofRowsInSection section: Int) -> Int {
//        return volunteer.count
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//
//        let cell = tableView.dequeueReusableCell(withIdentifier: "volunteerCell") as! VolunteersTableViewCell
//
//        let volunteerPost = volunteer[indexPath.row]
//
//
//        return cell
//}

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
