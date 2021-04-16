//
//  CreatedEventsTableViewCell.swift
//  Volunteer
//
//  Created by William Ordaz on 4/15/21.
//

import UIKit

class CreatedEventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventDate: UIDatePicker!
    @IBOutlet weak var eventTags: UILabel!
    @IBOutlet weak var difficultyImage: UIImageView!
    @IBOutlet weak var eventName: UILabel!
    @IBOutlet weak var eventImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
