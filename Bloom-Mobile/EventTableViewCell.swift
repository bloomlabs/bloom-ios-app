//
//  EventTableViewCell.swift
//  Bloom-Mobile
//
//  Created by Ashwin Daniel D'Cruz on 4/04/2016.
//  Copyright © 2016 Bloom. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {
    
    //MARK: Properties
    @IBOutlet weak var summary: UILabel!
    @IBOutlet weak var location: UILabel!
    @IBOutlet weak var eventDescription: UILabel!
    
  

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
