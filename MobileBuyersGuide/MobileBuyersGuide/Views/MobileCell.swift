//
//  MobileCell.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 18/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class MobileCell: UITableViewCell {
    
    @IBOutlet weak var phoneImageView: UIImageView!
    @IBOutlet weak var phoneDescriptionLabel: UILabel!
    @IBOutlet weak var phoneTitleLabel: UILabel!
    @IBOutlet weak var phonePriceLabel: UILabel!
    @IBOutlet weak var phoneRatingLabel: UILabel!
    
    func configure(mobileViewModel: MobileViewModel) {
        phoneImageView.image = mobileViewModel.image
        phoneTitleLabel.text = mobileViewModel.modelName
        phoneDescriptionLabel.text = mobileViewModel.description
        phonePriceLabel.text = "Price: \(mobileViewModel.price)"
        phoneRatingLabel.text = "Rating: \(mobileViewModel.rating)"
    }
}
