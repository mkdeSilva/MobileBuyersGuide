//
//  SortView.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 18/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class SortView: UIView {
    
    @IBAction func didTapPriceLowToHigh(_ sender: UIButton) {
        boldenSortOption(sender)
        delegate?.didTapSortPriceLowToHigh()
    }
    
    @IBAction func didTapPriceHighToLow(_ sender: UIButton) {
        boldenSortOption(sender)
        delegate?.didTapSortPriceHighToLow()
    }
    
    @IBAction func didTapRatingHighToLow(_ sender: UIButton) {
        boldenSortOption(sender)
        delegate?.didTapSortRatingHighToLow()
    }
    
    @IBAction func didTapCancel(_ sender: UIButton) {
        delegate?.didTapSortCancel()
    }
    
    @IBOutlet weak var ratingHighToLowButton : UIButton!
    
    weak var delegate : MobileListDelegate?
    
    var currentBoldButton : UIButton?
    
    // Sets the current bold button to default rating button and boldens it
    func configure() {
        currentBoldButton = ratingHighToLowButton
        boldenSortOption(currentBoldButton!)
    }
    
    // Un-applies bold of the currentBoldButton
    // Applies bold font to newButton and sets it to currentBoldButton
    fileprivate func boldenSortOption(_ button : UIButton) {
        guard let oldBoldButton = currentBoldButton else { return }
        
        guard let oldTitleLabel = oldBoldButton.titleLabel else {
            print("Missing title label on sort button. Please fix")
            return
        }
        
        guard let newTitleLabel = button.titleLabel else {
            print("Missing title label on sort button. Please fix")
            return
        }
        
        oldTitleLabel.font = UIFont.systemFont(ofSize: 15)
        newTitleLabel.font = UIFont.boldSystemFont(ofSize: 20)
        
        currentBoldButton = button
    }
    
}
