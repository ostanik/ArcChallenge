//
//  StopsTableViewCell.swift
//  ArcTouchChallenge
//
//  Created by Ostanik on 30/10/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//

import UIKit

class StopsTableViewCell: UITableViewCell {
    @IBOutlet weak var bottomLine: UIView!
    @IBOutlet weak var topLine: UIView!
    @IBOutlet weak var name: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

    func bind(stop:Stop, position: StopPosition) {
        self.name.text = stop.name
        switch position {
        case .first:
            self.topLine.isHidden = true
            break
        case .last:
            self.bottomLine.isHidden = true
            break
        default:
            self.bottomLine.isHidden = false
            self.topLine.isHidden = false
            break
        }
    }
    
}
