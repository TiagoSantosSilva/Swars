//
//  Species.swift
//  Swars
//
//  Created by Tiago Santos on 10/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

struct Species: Codable {
    let name: String?
    let classification: String?
    let designation: String?
    let averageHeight: String?
    let skinColors: String?
    let hairColors: String?
    let eyeColors: String?
    let averageLifespan: String?
    let homeworld: String?
    let language: String?
    let people: [String]?
    let films: [String]?
    let created: String?
    let edited: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case classification = "classification"
        case designation = "designation"
        case averageHeight = "average_height"
        case skinColors = "skin_colors"
        case hairColors = "hair_colors"
        case eyeColors = "eye_colors"
        case averageLifespan = "average_lifespan"
        case homeworld = "homeworld"
        case language = "language"
        case people = "people"
        case films = "films"
        case created = "created"
        case edited = "edited"
        case url = "url"
    }
}
