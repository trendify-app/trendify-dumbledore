//
//  PlayerTableViewCell.swift
//  trendify
//
//  Created by Mat Schmid on 2018-03-31.
//  Copyright © 2018 Mat Schmid. All rights reserved.
//

import UIKit

class PlayerTableViewCell: UITableViewCell {

    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var voteLabel: UILabel!
    @IBOutlet weak var scoreLabel: UILabel!
    
    func formatCellForName(name: String) {
        self.nicknameLabel.text = name
    }
    
    func formatForPlayer(player: Player) {
        self.nicknameLabel.text = player.name
        self.voteLabel.text = "Vote: \(player.vote)"
        self.scoreLabel.text = "\(player.score)"
    }

}
