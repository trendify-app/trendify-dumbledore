//
//  HomeViewController.swift
//  trendify
//
//  Created by Mat Schmid on 2018-03-31.
//  Copyright © 2018 Mat Schmid. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var hostButton: UIButton!
    @IBOutlet weak var joinButton: UIButton!
    
    var bgImageView: UIImageView = {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "homeBG")
        imgView.contentMode = .scaleAspectFill
        imgView.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        return imgView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        addBlurEffect()
        
        hostButton.layer.cornerRadius = 4
        joinButton.layer.cornerRadius = 4
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
    }
    
    func addBlurEffect() {
        let blur = UIBlurEffect(style: .light)
        let blurView = UIVisualEffectView(effect: blur)
        blurView.frame = bgImageView.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        
        view.addSubview(bgImageView)
        view.addSubview(blurView)
        
        view.sendSubview(toBack: blurView)
        view.sendSubview(toBack: bgImageView)
    }
    
    @IBAction func hostButtonTapped(_ sender: UIButton) {
        
    }
    
    @IBAction func joinButtonTapped(_ sender: UIButton) {
        
    }
    
}
