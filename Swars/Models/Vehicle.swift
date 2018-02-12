//
//  Vehicle.swift
//  Swars
//
//  Created by Tiago Santos on 11/02/18.
//  Copyright © 2018 Tiago Santos. All rights reserved.
//

import Foundation

struct Vehicle: Codable {
    let name: String?
    let model: String?
    let manufacturer: String?
    let costInCredits: String?
    let length: String?
    let maxAtmospheringSpeed: String?
    let crew: String?
    let passengers: String?
    let cargoCapacity: String?
    let consumables: String?
    let vehicleClass: String?
    let pilots: [String]?
    let films: [String]?
    let created: String?
    let edited: String?
    let url: String
    
    enum CodingKeys: String, CodingKey {
        case name = "name"
        case model = "model"
        case manufacturer = "manufacturer"
        case costInCredits = "cost_in_credits"
        case length = "length"
        case maxAtmospheringSpeed = "max_atmosphering_speed"
        case crew = "crew"
        case passengers = "passengers"
        case cargoCapacity = "cargo_capacity"
        case consumables = "consumables"
        case vehicleClass = "vehicle_class"
        case pilots = "pilots"
        case films = "films"
        case created = "created"
        case edited = "edited"
        case url = "url"
    }
}
