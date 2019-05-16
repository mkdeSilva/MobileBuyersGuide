//
//  ServiceAPI.swift
//  MobileBuyersGuide
//
//  Created by Mihindu de Silva on 16/05/2019.
//  Copyright © 2019 Mihindu de Silva. All rights reserved.
//

import Foundation

enum APIError : Error {
    case invalidJSON
    case invalidEndpoint
    case invalidResponse
    case apiError
}

class MobilePhoneServiceAPI {
    
    let session : URLSession
    
    let jsonDecoder : JSONDecoder = JSONDecoder()
    
    let baseURL = URL(string: "https://scb-test-mobile.herokuapp.com/api/")
    let mobileString = "mobiles"
    let imagesString = "images"
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
        
        if ( baseURL == nil){
            print("WARNING: Invalid Base URL")
        }
        
    }
    
    private func request<T : Decodable>(from url : URL, completion : @escaping (Result<T, APIError>) -> Void) {
        
        let dataTask = session.dataTask(with: url) { (result) in
            switch(result)
            {
            case .failure(let error):
                print("Error Occurred: \(error.localizedDescription)")
                completion(.failure(.apiError))
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, 200..<204 ~= statusCode else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    print(data)
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    DispatchQueue.main.async {
                        completion(.success(values))
                    }
                } catch {
                    completion(.failure(.invalidJSON))
                }
            }
        }
        
        dataTask.resume()
    }
    
    public func getAllMobilePhoneData(result: @escaping (Result<[MobilePhone], APIError>) -> Void) {
        guard var url = baseURL else { return }
        
        url.appendPathComponent(mobileString)

        request(from: url, completion: result)
    }
    
    public func getMobileDetail(mobileID : Int, result: @escaping (Result<[MobilePhoneDetail], APIError>) -> Void) {
        guard var url = baseURL else { return }
        
        url.appendPathComponent(mobileString)
        url.appendPathComponent(String(mobileID))
        url.appendPathComponent(imagesString)
        
        request(from: url, completion: result)
    }
}





