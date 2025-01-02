//
//  Pokemon.swift
//  Pokedex
//
//  Created by Quinn Butcher on 10/28/24.
//

import Foundation


struct Pokemon: Codable, Identifiable {
    let id: Int
    let name: String
    let types: [PokemonType]
    let height: Double
    let weight: Double
    let weaknesses: [PokemonType]
    let prevEvolution: [Int]?
    let nextEvolution: [Int]?
    var captured : Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case types
        case height
        case weight
        case weaknesses
        case prevEvolution
        case nextEvolution
        case captured
    }
    init(id: Int, name: String, types: [PokemonType], height: Double, weight: Double, weaknesses: [PokemonType], prevEvolution: [Int]?, nextEvolution: [Int]?, captured: Bool? = false) {
        self.id = id
        self.name = name
        self.types = types
        self.height = height
        self.weight = weight
        self.weaknesses = weaknesses
        self.prevEvolution = prevEvolution
        self.nextEvolution = nextEvolution
        self.captured = captured ?? false
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        id = try values.decode(Int.self, forKey: .id)
        name = try values.decode(String.self, forKey: .name)
        types = try values.decode([PokemonType].self, forKey: .types)
        height = try values.decode(Double.self, forKey: .height)
        weight = try values.decode(Double.self, forKey: .weight)
        weaknesses = try values.decode([PokemonType].self, forKey: .weaknesses)
        
        prevEvolution = try values.decodeIfPresent([Int].self, forKey: .prevEvolution) ?? nil
        nextEvolution = try values.decodeIfPresent([Int].self, forKey: .nextEvolution) ?? nil
        captured = try values.decodeIfPresent(Bool.self, forKey: .captured) ?? false
    }
    
    
}
