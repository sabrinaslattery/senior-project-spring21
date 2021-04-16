//
//  PreivousEventsTableViewCell.swift
//  Volunteer
//
//  Created by Sabrina Slattery on 3/23/21.
//

import UIKit

class MyEventsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var difficultyImage: UIImageView!
    @IBOutlet weak var eventDate: UIDatePicker!
    //@IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var eventTags: UILabel!
        
    //@IBOutlet weak var eventDate: UIDatePicker!
    //@IBOutlet weak var eventTags: UIPickerView!
    //@IBOutlet weak var eventDifficulty: UIPickerView!
        
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
