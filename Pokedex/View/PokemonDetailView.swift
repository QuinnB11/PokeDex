//
//  PokemonDetailView.swift
//  Pokedex
//
//  Created by Quinn Butcher on 10/28/24.
//

import SwiftUI

struct PokemonDetailView: View {
    @Environment(PokedexManager.self) var pokedexManager : PokedexManager
    @Environment(\.dismiss) var dismiss
    let pokemon: Pokemon

    var body: some View {
        ScrollView(.vertical, showsIndicators: true) {
            VStack(alignment: .center) {
                PokemonImage(pokemon: pokemon, frame: (width: 350, height: 350), cornerID: true)
                    .padding()
                HStack() {
                    Spacer()
                    Button {
                        pokedexManager.toggleCapturedStatus(for: pokemon.id)
                        dismiss()
                    } label: {
                        HStack {
                             Text("Captured: ")
                                .font(.callout)
                                .foregroundColor(.black)
                            Pokeball(captured: pokemon.captured, width: 30, height: 30)
                        }
                    }.padding(.trailing)
                }
                
                HStack {
                    NumberView(value: "Height", number: pokemon.height, caption: "m")
                    Spacer()
                    NumberView(value: "Weight", number: pokemon.weight, caption: "kg")
                }
                .padding()
                
                VStack(alignment: .leading) {
                    Text("Types")
                        .font(.title)
                        .fontWeight(.bold)
                    TypeView(types: pokemon.types)
                    
                    Text("Weaknesses")
                        .font(.title)
                        .fontWeight(.bold)
                    TypeView(types: pokemon.weaknesses)
                    
                    Text("Evolutions")
                        .font(.title)
                        .fontWeight(.bold)
                    evolutionWheel
                    
                }
                .padding(.horizontal)
            }
            .navigationTitle(pokemon.name)
        }
    }
}

extension PokemonDetailView {
    var evolutionWheel: some View {
        HStack(spacing: 2) {
            if let prevEvolutions = pokemon.prevEvolution {
                ForEach(0..<prevEvolutions.count, id: \.self) { index in
                    NavigationLink(destination: PokemonDetailView(pokemon: pokedexManager.pokedex[prevEvolutions[index] - 1])) {
                        PokemonImage(pokemon: pokedexManager.pokedex[prevEvolutions[index] - 1], frame: (width: 75, height: 75), cornerID: true)
                            .padding()
                    }
                    Image(systemName: "arrow.right.circle.fill")
                        .resizable()
                        .frame(width: 20, height: 20)
                        .foregroundColor(.secondary)
                }
            }

            PokemonImage(pokemon: pokemon, frame: (width: 100, height: 100), cornerID: true)
                .padding()

            if let nextEvolutions = pokemon.nextEvolution {
                Image(systemName: "arrow.right.circle.fill")
                    .resizable()
                    .frame(width: 20, height: 20)
                    .foregroundColor(.secondary)
                
                ForEach(0..<nextEvolutions.count, id: \.self) { index in
                    NavigationLink(destination: PokemonDetailView(pokemon: pokedexManager.pokedex[nextEvolutions[index] - 1])) {
                        PokemonImage(pokemon: pokedexManager.pokedex[nextEvolutions[index] - 1], frame: (width: 75, height: 75), cornerID: true)
                            .padding()
                    }
                    if index < nextEvolutions.count - 1 {
                        Image(systemName: "arrow.right.circle.fill")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(.secondary)
                    }
                }
            }
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
               prevEvolution: nil,
               nextEvolution: [2, 3],
               captured: false
           )
    
    PokemonDetailView(pokemon: samplePokemon)
        .environment(PokedexManager())
}
