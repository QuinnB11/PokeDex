//
//  CardView.swift
//  Pokedex
//
//  Created by Quinn Butcher on 11/4/24.
//

import SwiftUI

struct CardView: View {
    let pokemon: Pokemon
    let height: CGFloat
    let width: CGFloat
    var body: some View {
        ZStack(alignment: .top) {
            Rectangle()
                .fill(.card.opacity(0.6))
                .frame(width: width*1.2, height: height*1.5)
                .cornerRadius(12)
            PokemonImage(pokemon: pokemon, frame: (width: width, height: height), cornerID: true)
                .offset(y:10)
            Image(pokemon.captured == true ? "captured": "uncaptured")
                .resizable()
                .scaledToFit()
                .frame(width: 30, height: 30)
                .offset(x: width * 0.40, y: height * 1.15)
        }
    }
}

#Preview {
    let samplePokemon = Pokemon(
               id: 1,
               name: "Bulbasaur",
               types: [.grass, .poison],
               height: 0.71,
               weight: 6.9,
               weaknesses: [.fire, .ice, .flying, .psychic],
               prevEvolution: [],
               nextEvolution: [2, 3],
               captured: true
           )
    
    CardView(pokemon: samplePokemon, height: 100, width: 100)
        .environment(PokedexManager())
}

