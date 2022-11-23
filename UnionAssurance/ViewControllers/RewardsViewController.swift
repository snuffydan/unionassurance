//
//  RewardsViewController.swift
//  UnionAssurance
//
//  Created by Danushika Priyadarshani on 2022-11-22.
//

import UIKit

class RewardsViewController: BaseViewController {
    
    @IBOutlet weak var rewardTypeSelectionSegmentedControl: CustomSegmentedControl!
    @IBOutlet weak var completedRewadCollectionView: UICollectionView!
    @IBOutlet weak var incompleteRewardCollectionView: UICollectionView!
    
    let segmentSelectedFontColour = UIColor(red: 254/255, green: 173/255, blue: 40/255, alpha: 1)
    var completedRewards: [Reward] = []
    var incompleteRewards: [Reward] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let completeRewardCell = UINib(nibName: "rewardCollectionViewCell", bundle: nil)
        completedRewadCollectionView.register(completeRewardCell, forCellWithReuseIdentifier: REWARD_CELL_IDENTIFIER)
        
        let incompleteRewardCell = UINib(nibName: "rewardCollectionViewCell", bundle: nil)
        incompleteRewardCollectionView.register(incompleteRewardCell, forCellWithReuseIdentifier: REWARD_CELL_IDENTIFIER)
        
        setUpView()
        getRewards()
    
    }
    
    private func setUpView() {
        rewardTypeSelectionSegmentedControl.selectedSegmentIndex = 0
        rewardTypeSelectionSegmentedControl.sendActions(for: UIControl.Event.valueChanged)
        
        let font = UIFont.boldSystemFont(ofSize: 14)
        let normalAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: UIColor.darkGray]
        let selectedAttribute: [NSAttributedString.Key: Any] = [.font: font, .foregroundColor: segmentSelectedFontColour]
        rewardTypeSelectionSegmentedControl.setTitleTextAttributes(normalAttribute, for: .normal)
        rewardTypeSelectionSegmentedControl.setTitleTextAttributes(selectedAttribute, for: .selected)
    }
    
    private func getRewards() {
        if (isConnectedToInternet()) {
            showActivityIndicator()
            
            RewardManager.getRewards() { (result) in
                self.hideActivityIndicator()
                
                let allRewards = result ?? [Reward]()
                for reward in allRewards {
                    if reward.is_completed ?? false {
                        self.completedRewards.append(reward)
                    } else {
                        self.incompleteRewards.append(reward)
                    }
                }
                self.completedRewadCollectionView.reloadData()
                self.incompleteRewardCollectionView.reloadData()
            }
        }
    }

}


extension RewardsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if (collectionView == completedRewadCollectionView) {
            return self.completedRewards.count
        } else {
            return self.incompleteRewards.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == completedRewadCollectionView {
            let data = self.completedRewards[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: REWARD_CELL_IDENTIFIER, for: indexPath as IndexPath) as! RewardsCollectionViewCell

            cell.setUpCell(reward: data)
            return cell
        } else {
            let data = self.incompleteRewards[indexPath.row]
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: REWARD_CELL_IDENTIFIER, for: indexPath as IndexPath) as! RewardsCollectionViewCell

            cell.setUpCell(reward: data)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) { }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.size.width - 40
        return CGSize(width: width, height: 200)
    }
}
