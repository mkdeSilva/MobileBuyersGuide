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
    
    // Returns the list of MobileViewModels according to chosen options
    // If viewing All, returns allMobiles
    // If viewing Favourites, returns all favourited from allMobiles
    // Sorts the list based on current sort option
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
    }
    
    // Used for sorting the mobileToDisplay
    var sortOption : SortOption
    
    // Set when changing tabs between All & Favourites in ListView
    var showFavourites : Bool
    
    // Sets necessary variables with default sorting option set to Rating Five To One
    init(mobiles: [MobileViewModel], showFavourites : Bool, sortOption : SortOption = .ratingFiveToOne) {
        allMobiles = mobiles
        self.showFavourites = showFavourites
        self.sortOption = sortOption
    }
}

enum SortOption {
    case priceLowToHigh
    case priceHighToLow
    case ratingFiveToOne
}
