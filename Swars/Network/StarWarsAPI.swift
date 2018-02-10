//
//  StarWarsAPI.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation
import Moya

enum StarWarsAPI {
    case getPeoplePage(number: String)
    case getPerson(id: String)
}

extension StarWarsAPI: TargetType {
        
    // MARK: - Base Url
    
    var baseURL : URL {
        return URL(string: "https://swapi.co/api/")!
    }
    
    // MARK: - Paths
    
    var path: String {
        switch self {
        case .getPeoplePage(let number):
            return "people/?page=\(number)/"
        case .getPerson(let id):
            return "people/\(id)/"
        }
    }
    
    // MARK: - Methods
    
    var method: Moya.Method {
        switch self {
        case .getPeoplePage, .getPerson:
            return .get
        }
    }
    
    // MARK: - Tasks
    
    var task: Task {
        switch self {
        case .getPeoplePage, .getPerson:
            return .requestPlain
        }
    }
    
    // MARK: - Data
    
    var sampleData: Data {
        switch self {
        case .getPeoplePage:
            return "".utf8Encoded
        case .getPerson:
            return "".utf8Encoded
        }
    }
    
    // MARK: - Headers
    
    var headers: [String : String]? {
        return nil
    }
}





















