//
//  DetailView.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 18/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import UIKit

class DetailView: UIView {
    
    @IBOutlet weak var imageScrollView: UIScrollView!
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var isConfigured : Bool = false
    
    // Configure detailView if not configured
    // Sets the rating, price, and description
    // Calls SetImagesInScrollView
    func configure(with viewModel: MobileViewModel) {
        if (isConfigured) {
            return
        }
        
        ratingLabel.text = "Rating: \(viewModel.rating)"
        priceLabel.text = "Price: \(viewModel.price.formattedPrice())"
        descriptionLabel.text = viewModel.description
        
        guard let images = viewModel.detailViewModel?.images else {
            print("Cannot show images")
            return
        }
        SetImagesInScrollView(images)
        
        isConfigured = true
    }
    
    // Adds an imageView to the scrollView and calculates the frame for each image
    fileprivate func SetImagesInScrollView(_ images: [UIImage]) {
        
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.image = images[i]
            let xPosition = UIScreen.main.bounds.width * CGFloat(i)
            
            imageView.frame = CGRect(x: xPosition, y: 0, width: imageScrollView.frame.width, height: imageScrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            imageScrollView.addSubview(imageView)
        }
        
        imageScrollView.contentSize.width = imageScrollView.frame.width * CGFloat(images.count)
    }
}


