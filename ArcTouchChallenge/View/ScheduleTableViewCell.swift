//
//  ScheduleTableViewCell.swift
//  ArcTouchChallenge
//
//  Created by Ostanik on 30/10/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//

import UIKit

class ScheduleTableViewCell: UITableViewCell {

    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var calendar: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func bind(_ departure:Departure) {
        self.time.text = departure.time
        self.calendar.text = departure.calendar
    }
    
}
