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
    
    // Sets the rating, price, and description
    func configure(with viewModel: MobileViewModel) {
        ratingLabel.text = "Rating: \(viewModel.rating)"
        priceLabel.text = "Price: \(viewModel.price.formattedPrice())"
        descriptionLabel.text = viewModel.description
        
    }
    
    // Calls SetImagesInScrollView when images are received
    func setImages(with viewModel: MobileViewModel) {
        guard let images = viewModel.detailViewModel?.images else {
            print("Cannot show images")
            return
        }
        
        setImagesInScrollView(images)
    }
   
    
    // Adds an imageView to the scrollView and calculates the frame for each image
    fileprivate func setImagesInScrollView(_ images: [UIImage]) {
        
        imageScrollView.removeAllSubviews()
        
        for i in 0..<images.count {
            let imageView = UIImageView()
            imageView.image = images[i]
            let xPosition = (imageScrollView.frame.width / 1.5) * CGFloat(i)
       
            imageView.frame = CGRect(x: xPosition, y: 0, width: imageScrollView.frame.width, height: imageScrollView.frame.height)
            imageView.contentMode = .scaleAspectFit
            imageScrollView.addSubview(imageView)
        }
        
        imageScrollView.contentSize.width = (imageScrollView.frame.width / 1.5) * CGFloat(images.count + 1)
    }
}
