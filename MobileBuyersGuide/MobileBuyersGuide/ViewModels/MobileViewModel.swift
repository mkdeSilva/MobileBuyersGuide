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
    let image : UIImage
    let modelName : String
    let description : String
    let price : Double
    let rating : Double
    
    var isFavourite : Bool
    
    init(mobile: MobilePhone)
    {
        self.image = UIImage(named: "unknown-phone-image")!
        self.modelName = mobile.name
        self.description = mobile.description
        self.price = mobile.price
        self.rating = mobile.rating
        self.isFavourite = false
    }
}
