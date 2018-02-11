//
//  Planet.swift
//  Swars
//
//  Created by Tiago Santos on 11/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

struct Planet: Codable {
    let name: String?
    let rotationPeriod: String?
    let orbitalPeriod: String?
    let diameter: String?
    let climate: String?
    let gravity: String?
    let terrain: String?
    let surfaceWater: String?
    let population: String?
    let residents: [String]?
    let films: [String]?
    let created: String?
    let edited: String?
    let url: String?
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case rotationPeriod = "rotation_period"
        case orbitalPeriod = "orbital_period"
        case diameter = "diameter"
        case climate = "climate"
        case gravity = "gravity"
        case terrain = "terrain"
        case surfaceWater = "surface_water"
        case population = "population"
        case residents = "residents"
        case films = "films"
        case created = "created"
        case edited = "edited"
        case url = "url"
    }
}
