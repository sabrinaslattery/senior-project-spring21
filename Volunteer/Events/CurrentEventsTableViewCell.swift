//
//  CurrentEventsTableViewCell.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/23/21.
//

import UIKit

class CurrentEventsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var eventDate: UIImageView!
    @IBOutlet weak var eventDifficulty: UIImageView!
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
