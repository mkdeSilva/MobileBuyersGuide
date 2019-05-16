//
//  MobilePhoneAPIProtocol.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 16/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

protocol MobilePhoneAPIProtocol {
    func getMobileDetail(mobileID : Int, result: @escaping (Result<[MobilePhoneDetail], APIError>) -> Void)
    
    func getAllMobilePhoneData(result: @escaping (Result<[MobilePhone], APIError>) -> Void)
}
