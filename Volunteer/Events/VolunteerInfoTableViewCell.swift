//
//  VolunteerInfoTableViewCell.swift
//  Volunteer
//
//  Created by Karina Naranjo on 4/24/21.
//

import UIKit
import Parse

class VolunteerInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var volunteerName: UILabel!
    @IBOutlet weak var VolunteerEmail: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
