//
//  CustomSegmentedControl.swift
//  UnionAssurance
//
//  Created by Danushika Priyadarshani on 2022-11-23.
//

import UIKit

class CustomSegmentedControl: UISegmentedControl{
    
    private let segmentInset: CGFloat = 5
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        layer.cornerRadius = bounds.height/2
        backgroundColor = .white

        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex), let foregroundImageView = subviews[foregroundIndex] as? UIImageView
        {
            foregroundImageView.bounds = foregroundImageView.bounds.insetBy(dx: segmentInset, dy: segmentInset)
            
            let segmentColour = UIColor(red: 255/255, green: 232/255, blue: 191/255, alpha: 1)
            let segmentImage: UIImage? = UIImage(color: segmentColour)
            foregroundImageView.image = segmentImage
            
            foregroundImageView.layer.removeAnimation(forKey: "SelectionBounds")
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.layer.cornerRadius = foregroundImageView.bounds.height/2
        }
    }
}
