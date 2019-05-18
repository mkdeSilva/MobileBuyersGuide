//
//  MobilePhonesList.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 18/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

class MobilePhonesList {
    var allMobiles : [MobileViewModel]
    var mobilesToDisplay : [MobileViewModel] {
        get {
            return showFavourites ? allMobiles.filter(){$0.isFavourite} : allMobiles
        }
        
        set {}
    }
    
    var showFavourites = false
    
    init(mobiles: [MobileViewModel], showFavourites : Bool) {
        allMobiles = mobiles
        self.showFavourites = showFavourites
    }
}
