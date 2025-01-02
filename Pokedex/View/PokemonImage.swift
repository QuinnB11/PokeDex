//
//  PokemonImage.swift
//  Pokedex
//
//  Created by Quinn Butcher on 10/28/24.
//

import SwiftUI

struct PokemonImage: View {
    @Environment(PokedexManager.self) var pokedexManager : PokedexManager
    let pokemon : Pokemon
    private var formattedID: String {
        pokedexManager.formattedWithLeadingZeros(pokemon.id)
    }
    let frame: (width: CGFloat, height: CGFloat)
    let cornerID : Bool
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            if pokemon.types.count > 1 {
                LinearGradient(pokemonTypes: pokemon.types)
                    .cornerRadius(12)
            } else {
                Color(pokemon.types.first.map { Color(pokemonType: $0) } ?? .gray)
                    .cornerRadius(12)
            }
            Image(formattedID)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: frame.width, height: frame.height)
                .clipShape(RoundedRectangle(cornerRadius: 12))
                .padding(4)
            if cornerID {
                Text(formattedID)
                    .font(.caption)
                    .padding(4)
                    .background(Color.black.opacity(0.6))
                    .foregroundColor(.white)
                    .cornerRadius(5)
                    .padding(4)
            }
        }
        .frame(width: frame.width, height: frame.height)
        .shadow(radius: 5)
    }
}

