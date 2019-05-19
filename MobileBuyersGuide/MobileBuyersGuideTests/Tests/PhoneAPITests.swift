//
//  PhoneAPITests.swift
//  MobileBuyersGuideTests
//
//  Created by Mihindu de Silva on 19/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import XCTest
@testable import MobileBuyersGuide

class PhoneAPITests : XCTestCase {
    
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
}
