//
//  CurrentEventsTableViewCell.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/22/21.
//

import UIKit

class CurrentEventsTableViewCell: UITableViewCell {

    @IBOutlet weak var eventDate: UIView!
    @IBOutlet weak var eventImage: UIImageView!
    @IBOutlet weak var eventDifficulty: UIImageView!
    
    @IBOutlet weak var eventName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}
