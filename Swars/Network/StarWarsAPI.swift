//
//  StarWarsAPI.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation
import Moya

struct StarWarsEndpoints {
    static let vehicleEndpoint = "vehicles/"
    static let personEndpoint = "people/"
    static let planetEndpoint = "planets/"
}

enum StarWarsAPI {
    case getPeoplePage(number: String?)
    case getPerson(id: String)
    case getSpecies(id: String)
    case getPlanet(id: String)
}

extension StarWarsAPI: TargetType {
        
    // MARK: - Base Url
    
    var baseURL : URL {
        return URL(string: "https://swapi.co/api/")!
    }
    
    // MARK: - Paths
    
    var path: String {
        switch self {
        case .getPeoplePage(_):
            return "people"
        case .getPerson(let id):
            return "people/\(id)"
        case .getSpecies(let id):
            return "species/\(id)"
        case .getPlanet(let id):
            return "planets/\(id)"
        }
    }
    
    // MARK: - Methods
    
    var method: Moya.Method {
        switch self {
        case .getPeoplePage, .getPerson, .getSpecies, .getPlanet:
            return .get
        }
    }
    
    // MARK: - Tasks
    
    var task: Task {
        switch self {
        case .getPeoplePage(let page):
            var params: [String: Any] = [:]
            params["page"] = page
            return .requestParameters(parameters: params, encoding: URLEncoding.default)
        default:
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
        case .getSpecies:
            return "".utf8Encoded
        case .getPlanet:
            return "".utf8Encoded
        }
    }
    
    // MARK: - Headers
    
    var headers: [String : String]? {
        return nil
    }
    
    // MARK: - Parameter Encoding
    
    var parameterEncoding: ParameterEncoding {
        switch self {
        default:
            return URLEncoding.default
        }
    }
}
