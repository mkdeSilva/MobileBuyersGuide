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
    @IBOutlet weak var favouriteButton: UIButton!
    
    @IBAction func didTapFavourite(_ sender: UIButton) {
        delegate?.didTapFavourite(with: sender.tag)
    }
    
    
 
    weak var delegate : MobileListDelegate?
    
    override func awakeFromNib() {
        favouriteButton.imageView?.contentMode = .scaleAspectFit
    }
    
    func configure(mobileViewModel: MobileViewModel, index: Int) {
        phoneImageView.image = mobileViewModel.image
        phoneTitleLabel.text = mobileViewModel.modelName
        phoneDescriptionLabel.text = mobileViewModel.description
        phonePriceLabel.text = "Price: \(mobileViewModel.price.formattedPrice())"
        phoneRatingLabel.text = "Rating: \(mobileViewModel.rating)"
        
        setFavouriteButtonImage(favourite: mobileViewModel.isFavourite)
       
        favouriteButton.tag = index
    }
    
    func setFavouriteButtonImage(favourite : Bool) {
        if (favourite) {
            favouriteButton.setImage(UIImage(named: "favourite"), for: .normal)
        } else {
            favouriteButton.setImage(UIImage(named: "non-favourite"), for: .normal)
        }
    }
    
    func setFavouriteButtonState(hidden : Bool) {
        
        if (hidden) {
            favouriteButton.setImage(nil, for: .normal)
            favouriteButton.isUserInteractionEnabled = false
        } else {
            favouriteButton.isUserInteractionEnabled = true
        }
    }
}
