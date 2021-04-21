//
//  VolunteersTableViewCell.swift
//  Volunteer
//
//  Created by William Ordaz on 4/15/21.
//

import UIKit
import Parse

class VolunteersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var volunteerName: UILabel!
    @IBOutlet weak var volunteerEmail: UILabel!
    
    var user = PFObject(className: "User")
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
