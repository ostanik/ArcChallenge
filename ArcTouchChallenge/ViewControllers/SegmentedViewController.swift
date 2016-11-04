//
//  SegmentedViewController.swift
//  ArcTouchChallenge
//
//  Created by Ostanik on 29/10/16.
//  Copyright © 2016 Ostanik. All rights reserved.
//

import Foundation
import MXSegmentedPager

class SegmentedViewController: MXSegmentedPagerController, SelectableRoute {
    let titles:[String] = ["Stops","Weakdays schedule","Weekends schedule"]
    var selectedRoute: Route? = nil

    // MARK: - UIViewController methods.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Segmented Control customization
        self.segmentedPager.segmentedControl.selectionIndicatorLocation = .down
        self.segmentedPager.segmentedControl.backgroundColor = UIColor.white
        self.segmentedPager.segmentedControl.selectionStyle = .fullWidthStripe
        self.segmentedPager.segmentedControl.selectionIndicatorColor = UIColor.black

        self.segmentedPager.segmentedControlEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0)
        self.segmentedPager.layoutSubviews()

        self.title = selectedRoute?.longName
    }

    override func viewDidLayoutSubviews() {
        self.segmentedPager.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfPages(in segmentedPager: MXSegmentedPager) -> Int {
        return 3
    }

    override func segmentedPager(_ segmentedPager: MXSegmentedPager, titleForSectionAt index: Int) -> String {
        return titles[index];
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if var vc = segue.destination as? SelectableRoute {
            vc.selectedRoute = self.selectedRoute
        }
    }

}
