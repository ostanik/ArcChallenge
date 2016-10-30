//
//  StopsTableViewController.swift
//  ArcTouchChallenge
//
//  Created by Ostanik on 29/10/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//

import UIKit

class StopsTableViewController: UITableViewController, SelectableRoute {
    var selectedRoute: Route? = nil
    var results:Result<Stop>? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        if let route = selectedRoute {
            SearchService.findStopsBy(routeId: route.id!, success: { (result) in
                self.results = result
                self.tableView.reloadData()
            })
        }
        tableView.register(StopsTableViewCell.self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return results != nil ? (results?.rows?.count)! : 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as StopsTableViewCell

        switch indexPath.row {
        case 0:
            cell.bind(stop: (self.results?.rows?[indexPath.row])!, position: .first)
            break
        case (self.results?.rows?.count)! - 1:
            cell.bind(stop: (self.results?.rows?[indexPath.row])!, position: .last)
            break
        default:
            cell.bind(stop: (self.results?.rows?[indexPath.row])!, position: .middle)
            break
        }
        return cell
    }
}
