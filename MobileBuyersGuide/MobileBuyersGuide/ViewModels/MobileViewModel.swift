//
//  MobileViewModel.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 18/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import Foundation
import UIKit

class MobileViewModel {
    var image : UIImage
    let modelName : String
    let description : String
    let price : Double
    let rating : Double
    let imageUrl : String
    let mobileId : Int
    var isFavourite : Bool
    var detailViewModel : DetailViewModel?
    
    init(mobile: MobilePhone)
    {
        self.image = UIImage(named: "unknown-phone-image")!
        self.modelName = mobile.name
        self.description = mobile.description
        self.price = mobile.price
        self.rating = mobile.rating
        self.isFavourite = false
        self.mobileId = mobile.id
        self.imageUrl = mobile.thumbImageURL
        self.detailViewModel = nil
    }
    
    func setImage(_ image: UIImage) {
        self.image = image
    }
}
