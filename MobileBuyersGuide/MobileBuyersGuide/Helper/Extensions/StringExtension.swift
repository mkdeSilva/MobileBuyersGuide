//
//  StringExtension.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 19/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

extension String {
    mutating func prefixWithHTTPS() {
        if (self.hasPrefix("https"))
        {
            return
        }
        
        if (self.hasPrefix("http")) {
            let startIndex = self.startIndex
            let endIndex = self.index(startIndex, offsetBy: 4)
            self.replaceSubrange(startIndex..<endIndex, with: "https")
        } else {
            self = "https://" + self
        }
    }
}
