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
    
    func testMobilePhoneDataResponse() {
        let phoneData = [
            [
                "description": "First place in our list goes to the excellent Moto E4 Plus. It's a cheap phone that features phenomenal battery life, a fingerprint scanner and a premium feel design, plus it's a lot cheaper than the Moto G5 below. It is a little limited with its power, but it makes up for it by being able to last for a whole two days from a single charge. If price and battery are the most important features for you, the Moto E4 Plus will suit you perfectly.",
                "thumbImageURL": "https://cdn.mos.cms.futurecdn.net/grwJkAGWQp4EPpWA3ys3YC-650-80.jpg",
                "brand": "Samsung",
                "price": 179.99,
                "id": 1,
                "name": "Moto E4 Plus",
                "rating": 4.9
            ], [
                "description": "Nokia is back in the mobile phone game and after a small price drop to the Nokia 6 we've now seen it enter our best cheap phone list. It comes with a Full HD 5.5-inch display, full metal design and a fingerprint scanner for added security. The battery isn't incredible on the Nokia 6, but it's not awful either making this one of our favorite affordable phones on the market right now.",
                "thumbImageURL": "https://cdn.mos.cms.futurecdn.net/8LWUERoxMAWavvVAAbxuac-650-80.jpg",
                "brand": "Nokia",
                "price": 199.99,
                "id": 2,
                "name": "Nokia 6",
                "rating": 4.6
            ]
        ]
        
        let mockAPI = MockMobilePhoneAPI(phoneData: phoneData)
        
        mockAPI.getAllMobilePhoneData() { (result) in
            switch(result)
            {
            case .failure(_):
                XCTFail("Result failed to get data")
            case .success(let values):
                XCTAssert(values.first?.brand == "Samsung")
            }
        }
    }
    
    func testMobileDetailResponse() {
        let mockDetail = [[
            "id": 1,
            "mobile_id": 1,
            "url": "https://www.91-img.com/gallery_images_uploads/f/c/fc3fba717874d64cf15d30e77a16617a1e63cc0b.jpg"
            ], [
                "id": 6,
                "mobile_id": 1,
                "url": "https://www.91-img.com/gallery_images_uploads/b/4/b493185e7767c2a99cfeef712b11377f625766f2.jpg"
            ], [
                "id": 7,
                "mobile_id": 1,
                "url": "https://www.91-img.com/gallery_images_uploads/c/3/c32cff8945621ad06c929f50af9f7c55f978c726.jpg"
            ]]
        
        let mockAPI = MockMobilePhoneAPI(detailData: mockDetail)
        mockAPI.getMobileDetail(mobileID: 1) { (result) in
            switch(result) {
            case .failure(_):
                XCTFail()
            case .success(let details):
                XCTAssert(details.last?.id == 7)
            }
        }
    }
    
    func testFormattedPrice() {
        let price = 238.483
        let formattedPrice = price.formattedPrice()
        XCTAssert(formattedPrice == "$238.48")
    }
    
    func testConstructViewModelFromModel()
    {
        let mobileModel = MobilePhone(thumbImageURL: "someURL", rating: 5.0, price: 999.99, brand: "Apple", description: "Not a potato", name: "iPhone 3GS", id: 1)
        
        let mobileViewModel = MobileViewModel(mobile: mobileModel)
        
        XCTAssertTrue(mobileViewModel.modelName == "iPhone 3GS")
    }
    
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

