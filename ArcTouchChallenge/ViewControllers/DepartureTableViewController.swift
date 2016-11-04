//
//  DepartureTableViewController.swift
//  ArcTouchChallenge
//
//  Created by Ostanik on 30/10/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//

import UIKit

class DepartureTableViewController: UITableViewController, SelectableRoute {
    var selectedRoute: Route? = nil
    var result: [Departure]? = nil

    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(ScheduleTableViewCell.self)
        if self.selectedRoute != nil {
            self.search()
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return result != nil ? (result?.count)! : 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as ScheduleTableViewCell
        cell.bind((result?[indexPath.row])!)
        return cell
    }

    func search(){ }
}

class WeekdayTableViewController: DepartureTableViewController {
    override func search() {
        SearchService.findDepartureBy(routeId: (self.selectedRoute?.id!)!, success: { result in
            if let r = result.rows {
                self.result = r.filter({$0.calendar == Calendar.weekDay.rawValue})
                self.tableView.reloadData();
            }
        })
    }
}

class WeekendsTableViewController: DepartureTableViewController {
    override func search() {
        SearchService.findDepartureBy(routeId: (self.selectedRoute?.id!)!, success: { result in
            if let r = result.rows {
                self.result = r.filter({$0.calendar != Calendar.weekDay.rawValue})
                self.tableView.reloadData();
            }
        })
    }
}
