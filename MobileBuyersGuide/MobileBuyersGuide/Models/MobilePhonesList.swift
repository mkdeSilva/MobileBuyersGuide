//
//  MobilePhonesList.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 18/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

class MobilePhonesList {
    fileprivate var allMobiles : [MobileViewModel]
    
    var mobilesToDisplay : [MobileViewModel] {
        get {
            let phones = showFavourites ? allMobiles.filter(){$0.isFavourite} : allMobiles

            switch(sortOption) {
            case .priceHighToLow:
                return phones.sorted() {$0.price > $1.price}
            case .priceLowToHigh:
                return phones.sorted() {$0.price < $1.price}
            case .ratingFiveToOne:
                return phones.sorted() {$1.rating < $0.rating}
            }
        }
        
        set {}
    }
    
    var sortOption : SortOption
    
    var showFavourites = false
    
    init(mobiles: [MobileViewModel], showFavourites : Bool) {
        allMobiles = mobiles
        self.showFavourites = showFavourites
        self.sortOption = .ratingFiveToOne
    }
}

enum SortOption {
    case priceLowToHigh
    case priceHighToLow
    case ratingFiveToOne
}
