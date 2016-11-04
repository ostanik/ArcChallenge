//
//  RouteTableViewCell.swift
//  ArcTouchChallenge
//
//  Created by Ostanik on 29/10/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//

import UIKit

class RouteTableViewCell: UITableViewCell {
    var route:Route! = nil;

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }

    func bind(_ route:Route) {
        self.textLabel?.text = route.longName
        self.detailTextLabel?.text = "\(route.shortName)"
        self.route = route
    }

}
