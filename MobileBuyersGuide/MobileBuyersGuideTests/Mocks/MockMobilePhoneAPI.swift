//
//  MockMobilePhoneAPI.swift
//  MobileBuyersGuideTests
//
//  Created by Mihindu de Silva on 16/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

@testable import MobileBuyersGuide

class MockMobilePhoneAPI : MobilePhoneAPIProtocol {
    let mockMobileDetailData : [[String : Any]]
    let mockMobilePhoneData : [[String : Any]]
    let mockImageData : Data?
    
    init(phoneData : [[String : Any]] = [["":""]] , detailData : [[String : Any]] = [["":""]], imageData : Data? = nil) {
        mockMobilePhoneData = phoneData
        mockMobileDetailData = detailData
        mockImageData = imageData
    }
    
    func getAllMobilePhoneData(result: @escaping (Result<[MobilePhone], APIError>) -> Void) {
        guard let data = try? JSONSerialization.data(withJSONObject: mockMobilePhoneData) else {
            result(.failure(.invalidJSON))
            return
        }
        
        guard let values = try? JSONDecoder().decode([MobilePhone].self, from:data) else {
            result(.failure(.apiError))
            return
        }
        
        result(.success(values))
    }
    
    func getMobileDetail(mobileID: Int, result: @escaping (Result<[MobilePhoneDetail], APIError>) -> Void) {
        
        guard let data = try? JSONSerialization.data(withJSONObject: mockMobileDetailData) else {
            result(.failure(.invalidJSON))
            return
        }
        guard let values = try? JSONDecoder().decode([MobilePhoneDetail].self, from:data) else {
            result(.failure(.apiError))
            return
        }
        
        result(.success(values))
    }
    
    func getImage(urlString: String, result: @escaping (Result<Data, APIError>) -> Void) {
        guard let data = mockImageData else {
            result(.failure(.apiError))
            return
        }
        
        result(.success(data))
    }
    
   
}
