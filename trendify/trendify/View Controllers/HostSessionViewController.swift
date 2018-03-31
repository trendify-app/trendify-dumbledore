//
//  HostSessionViewController.swift
//  trendify
//
//  Created by Mat Schmid on 2018-03-31.
//  Copyright © 2018 Mat Schmid. All rights reserved.
//

import UIKit

class HostSessionViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }

}
