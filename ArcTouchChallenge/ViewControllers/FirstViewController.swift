//
//  ViewController.swift
//  ArcTouchChallenge
//
//  Created by Ostanik on 29/10/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//

import UIKit

class FirstViewController: UITableViewController, UISearchResultsUpdating {
    var result: Result<Route>? = nil
    let searchController = UISearchController(searchResultsController: nil)
    var timer: Timer! = nil

    private final func setup() {
        self.navigationController?.navigationBar.isTranslucent = false
        self.createSearchController()
        tableView.register(RouteTableViewCell.self)
        self.performSearchWith(string:"")
    }

    private final func createSearchController() {
        self.searchController.searchResultsUpdater = self
        self.searchController.dimsBackgroundDuringPresentation = false
        self.searchController.hidesNavigationBarDuringPresentation = false
        self.searchController.searchBar.isTranslucent = false
        self.searchController.searchBar.backgroundImage = UIImage()
        self.searchController.searchBar.barTintColor = UIColor.black
        self.searchController.searchBar.tintColor = UIColor.white
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }

    // MARK: - UIViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setup()
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.result != nil ? (self.result?.rows?.count)! : 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(forIndexPath: indexPath) as RouteTableViewCell
        cell.bind((self.result?.rows?[indexPath.row])!)
        return cell
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.searchController.isActive = false;
        self.performSegue(withIdentifier: "ShowMore", sender: tableView.cellForRow(at: indexPath))
    }

    // MARK: - Search
    @available(iOS 8.0, *)
    public func updateSearchResults(for searchController: UISearchController){
        //Creating a timer to handle sequential typing
        if self.timer != nil {
            timer.invalidate()
        }
        self.timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.process), userInfo: ["text":searchController.searchBar.text!], repeats: false)
    }

    @objc private func process(timer:Timer) {
        if let text = ((timer.userInfo as! NSDictionary)["text"] as? String) {
            self.performSearchWith(string: text)
        }
    }

    private final func performSearchWith(string:String) {
        SearchService.findRoutesBy(stopName: string, success: { (result) in
            self.result = result
            self.tableView.reloadData()
        })
    }

    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //Removing back title
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        // Pass the selected object to the new view controller.
        (segue.destination as! SegmentedViewController).selectedRoute = (sender as! RouteTableViewCell).route
    }
}

