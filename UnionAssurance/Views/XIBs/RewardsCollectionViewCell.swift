//
//  RewardsCollectionViewCell.swift
//  UnionAssurance
//
//  Created by Danushika Priyadarshani on 2022-11-22.
//

import UIKit
import SDWebImage

let REWARD_CELL_IDENTIFIER = "rewardsCell"

class RewardsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var rewardStatusView: UIView!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var rewardStatusLabel: UILabel!
    @IBOutlet weak var rewardTitleLabel: UILabel!
    @IBOutlet weak var rewardSubtitleLabel: UILabel!
    @IBOutlet weak var expireDateLabel: UILabel!
    
    let completedColour = UIColor(red: 45/255, green: 155/255, blue: 91/255, alpha: 1)
    let incompletedColour = UIColor(red: 160/255, green: 160/255, blue: 162/255, alpha: 1)
        
    func setUpCell(reward: Reward) {
        rewardStatusView.backgroundColor = (reward.is_completed ?? false) ? completedColour : incompletedColour
        rewardStatusLabel.text = (reward.is_completed ?? false) ? "COMPLETED" : "NOT COMPLETED"
        
        rewardTitleLabel.text = reward.title
        rewardSubtitleLabel.text = reward.sub_title
        print("\(reward.imageURL ?? URL(string: ""))")
        backgroundImageView.sd_setImage(with: reward.imageURL, completed: nil)
    }
}
