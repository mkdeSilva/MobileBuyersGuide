//
//  SortView.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 18/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class SortView: UIView {
    
  
    @IBAction func didTapPriceLowToHigh(_ sender: Any) {
         delegate?.didTapSortPriceLowToHigh()
    }
    
    @IBAction func didTapPriceHighToLow(_ sender: Any) {
        delegate?.didTapSortPriceHighToLow()
    }
    
    @IBAction func didTapRatingHighToLow(_ sender: Any) {
        delegate?.didTapSortRatingHighToLow()
    }
    
    @IBAction func didTapCancel(_ sender: Any) {
         delegate?.didTapSortCancel()
    }
    
    weak var delegate : MobileListDelegate?
    
    func configure() {
        
    }
    
}
