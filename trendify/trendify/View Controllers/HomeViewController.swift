//
//  HomeViewController.swift
//  trendify
//
//  Created by Mat Schmid on 2018-03-31.
//  Copyright © 2018 Mat Schmid. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    var bgImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "homeBG")
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.isNavigationBarHidden = true
        view.addSubview(bgImageView)
        
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = bgImageView.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.addSubview(blurView)
        
        view.sendSubview(toBack: blurView)
        view.sendSubview(toBack: bgImageView)
    }
}
