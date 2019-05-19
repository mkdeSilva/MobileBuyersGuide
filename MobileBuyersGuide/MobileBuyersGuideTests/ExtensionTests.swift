//
//  ExtensionTests.swift
//  MobileBuyersGuideTests
//
//  Created by Mihindu de Silva on 19/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import XCTest
@testable import MobileBuyersGuide

class ExtensionTests: XCTestCase {
    
    func testReplaceURLStringWithHTTPS() {
        var urlWithHTTPS = "https://www.91.img.com"
        var urlWithHTTP = "http://www.91.img.com"
        var urlWithout = "www.91.img.com"
        
        urlWithHTTPS.prefixWithHTTPS()
        urlWithHTTP.prefixWithHTTPS()
        urlWithout.prefixWithHTTPS()
        
        XCTAssertEqual("https://www.91.img.com", urlWithHTTPS)
        XCTAssertEqual("https://www.91.img.com", urlWithHTTP)
        XCTAssertEqual("https://www.91.img.com", urlWithout)
    }
    
    func testFormattedPrice() {
        let price = 238.483
        let formattedPrice = price.formattedPrice()
        XCTAssert(formattedPrice == "$238.48")
    }
}
