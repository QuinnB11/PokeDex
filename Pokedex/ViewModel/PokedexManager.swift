//
//  PokedexManager.swift
//  Pokedex
//
//  Created by Quinn Butcher on 10/28/24.
//

import Foundation

@Observable
class PokedexManager {
    
    
    var pokedex : [Pokemon]
    
    let persistancePokemon : StorageManager = StorageManager<[Pokemon]>(filename: "pokedex")
    
    
    init() {
        pokedex = persistancePokemon.modelData ?? []
    }
    
    
    func formattedWithLeadingZeros(_ number: Int) -> String {
        return String(format: "%0\(3)d", number)
    }
    func toggleCapturedStatus(for id: Int) {
        if let index = pokedex.firstIndex(where: { $0.id == id }) {
            pokedex[index].captured.toggle()
        }
        save()
        
    }
    
    func save() {
        persistancePokemon.save(components: pokedex)
    }
    
}

