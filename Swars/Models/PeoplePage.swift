//
//  PeoplePage.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

struct PeoplePage: Decodable {
    let count: Int?
    let next: String?
    let previous: String?
    let results: [Person]?
    
    enum CodingKeys: String, CodingKey {
        case count = "count"
        case next = "next"
        case previous = "previous"
        case results = "results"
    }
}
