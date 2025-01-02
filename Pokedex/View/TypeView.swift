//
//  TypeView.swift
//  Pokedex
//
//  Created by Quinn Butcher on 10/28/24.
//

import SwiftUI

struct TypeView: View {
    let types: [PokemonType]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack {
                ForEach(types, id: \.self) { type in
                    Text(type.rawValue.capitalized)
                        .padding(8)
                        .background(Color(pokemonType: type))
                        .cornerRadius(10)
                        .foregroundColor(.white)
                }
            }
        }
    }
}

