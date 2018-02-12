//
//  StarWarsDataManager.swift
//  Swars
//
//  Created by Tiago Santos on 11/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

typealias DataCompletion = (AnyObject?, DataManagerError?) -> ()

final class StarWarsDataManager {
    
    let baseURL: URL = URL(string: "https://swapi.co/api/")!
    
    func getData<T: Codable>(endpoint: String, _ type: T.Type, completion: @escaping DataCompletion) {
        
        let requestUrl = baseURL.appendingPathComponent(endpoint)
        
        URLSession.shared.dataTask(with: requestUrl) { (data, response, error) in
            self.didFetchData(data: data, response: response, error: error, T.self, completion: completion)
            }.resume()
    }
    
    private func didFetchData<T: Codable>(data: Data?, response: URLResponse?, error: Error?, _ type: T.Type, completion: DataCompletion) {
        guard error == nil else {
            completion(nil, .FailedRequest)
            return
        }
        
        guard let data = data, let response = response as? HTTPURLResponse
            else {
                completion(nil, .Unknown)
                return
        }
        
        guard response.statusCode == 200 else {
            completion(nil, .FailedRequest)
            return
        }
        
        processData(data: data, T.self, completion: completion)
    }
    
    private func processData<T: Codable>(data: Data, _ type: T.Type, completion: DataCompletion) {
        guard let dataDecoded = try? JSONDecoder().decode(T.self, from: data) as AnyObject else {
            completion(nil, .InvalidResponse)
            return
        }
        
        completion(dataDecoded, nil)
        return
    }
}
