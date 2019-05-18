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

class MobilePhoneAPI {
    
    private let session : URLSession
    
    private let jsonDecoder : JSONDecoder = JSONDecoder()
    
    private let baseURL = URL(string: "https://scb-test-mobile.herokuapp.com/api/")
    private let mobileString = "mobiles"
    private let imagesString = "images"
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
        
        if ( baseURL == nil){
            print("WARNING: Invalid Base URL")
        }
    }
    
    private func requestJSON<T : Decodable>(from url : URL, completion : @escaping (Result<T, APIError>) -> Void) {
        
        let dataTask = session.dataTask(with: url) { (result) in
            switch(result)
            {
            case .failure(_):
                completion(.failure(.apiError))
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                do {
                    print(data)
                    let values = try self.jsonDecoder.decode(T.self, from: data)
                    completion(.success(values))
                    
                } catch {
                    completion(.failure(.invalidJSON))
                }
            }
        }
        
        dataTask.resume()
    }
    
    private func download(from url : URL, completion : @escaping (Result<Data, APIError>) -> Void) {
        
        let dataTask = session.dataTask(with: url) { (result) in
            switch(result)
            {
            case .failure(_):
                completion(.failure(.apiError))
            case .success(let (response, data)):
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode, statusCode == 200 else {
                    completion(.failure(.invalidResponse))
                    return
                }
                completion(.success(data))
            }
        }
        
        dataTask.resume()
    }
    
}

extension MobilePhoneAPI : MobilePhoneAPIProtocol {
    
    public func getAllMobilePhoneData(result: @escaping (Result<[MobilePhone], APIError>) -> Void) {
        guard var url = baseURL else { return }
        
        url.appendPathComponent(mobileString)
        
        requestJSON(from: url, completion: result)
    }
    
    public func getMobileDetail(mobileID : Int, result: @escaping (Result<[MobilePhoneDetail], APIError>) -> Void) {
        guard var url = baseURL else { return }
        
        url.appendPathComponent(mobileString)
        url.appendPathComponent(String(mobileID))
        url.appendPathComponent(imagesString)
        
        requestJSON(from: url, completion: result)
    }
    
    public func getImage(urlString : String, result : @escaping (Result<Data, APIError>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        download(from: url, completion: result)
    }
}




