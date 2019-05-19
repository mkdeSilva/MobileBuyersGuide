//
//  MobileBuyersGuideTests.swift
//  MobileBuyersGuideTests
//
//  Created by Mihindu de Silva on 15/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import XCTest
@testable import MobileBuyersGuide

class MobileBuyersGuideTests: XCTestCase {
    
    let mobileModels = [
        MobilePhone(thumbImageURL: "onePlusUrl", rating: 4.8, price: 699.3, brand: "OnePlus", description: "Not a two minus", name: "OnePlus 7 Pro", id : 1),
        MobilePhone(thumbImageURL: "ancient.jpeg", rating: 2.3, price: 231.2, brand: "Palm", description: "Is this ancient?", name: "Palm TX", id : 2),
        MobilePhone(thumbImageURL: "hotStuff", rating: 3, price: 23.3, brand: "Samsung", description: "These things aren't allowed on planes", name: "Samsung Note 7", id : 3),
    ]
    
    var viewModels : [MobileViewModel] = []
    var mobileList = MobilePhonesList(mobiles: [], showFavourites: false)
    
    override func setUp() {
        viewModels = mobileModels.compactMap(MobileViewModel.init)
        mobileList = MobilePhonesList(mobiles: viewModels, showFavourites: false)
    }
    
    func testConstructViewModelFromModel()
    {
        let mobileModel = MobilePhone(thumbImageURL: "someURL", rating: 5.0, price: 999.99, brand: "Apple", description: "Not a potato", name: "iPhone 3GS", id: 1)
        
        let mobileViewModel = MobileViewModel(mobile: mobileModel)
        
        XCTAssertTrue(mobileViewModel.modelName == "iPhone 3GS")
    }
    
    func testListFavourites() {
        viewModels[0].isFavourite.toggle()
        XCTAssert(mobileList.mobilesToDisplay.count > 0)
        mobileList.showFavourites = true
        XCTAssertEqual(mobileList.mobilesToDisplay.count, 1)
        viewModels[1].isFavourite.toggle()
        XCTAssertEqual(mobileList.mobilesToDisplay.count, 2)
    }
    
    func testSorting() {
        mobileList.sortOption = .ratingFiveToOne // This is default sort option
        XCTAssertEqual(mobileList.mobilesToDisplay[0].modelName, "OnePlus 7 Pro")
        XCTAssertEqual(mobileList.mobilesToDisplay[1].modelName, "Samsung Note 7")
        XCTAssertEqual(mobileList.mobilesToDisplay[2].modelName, "Palm TX")
        
        mobileList.sortOption = .priceHighToLow
        XCTAssertEqual(mobileList.mobilesToDisplay[0].price, 699.3)
        XCTAssertEqual(mobileList.mobilesToDisplay[1].price, 231.2)
        XCTAssertEqual(mobileList.mobilesToDisplay[2].price, 23.3)

        mobileList.sortOption = .priceLowToHigh
        XCTAssertEqual(mobileList.mobilesToDisplay[0].price, 23.3)
        XCTAssertEqual(mobileList.mobilesToDisplay[1].price, 231.2)
        XCTAssertEqual(mobileList.mobilesToDisplay[2].price, 699.3)
    }
}
