//
//  RowView.swift
//  Pokedex
//
//  Created by Quinn Butcher on 11/3/24.
//

import SwiftUI

struct RowView: View {
    @Environment(PokedexManager.self) var pokedexManager : PokedexManager
    @AppStorage(Storage.sorting) var selectedType : PokemonType = .none
    
    private var filteredPokemon: [Pokemon] {
        if selectedType.isAllTypes {
            return pokedexManager.pokedex
        } else {
            return pokedexManager.pokedex.filter { pokemon in
                pokemon.types.contains(selectedType)
            }
        }
    }
        
    var body: some View {
            NavigationStack {
                VStack{
                    HStack {
                        Spacer()
                        Picker("Select Type", selection: $selectedType) {
                            ForEach(PokemonType.allTypes) { type in
                                Text(type.rawValue).tag(type)
                            }
                        }
                        .pickerStyle(MenuPickerStyle())
                        .foregroundColor(.back)
                        .padding(.horizontal)

                    }
                    .padding(.top)
                    List(filteredPokemon) { pokemon in
                        NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                            HStack {
                                let formattedID = pokedexManager.formattedWithLeadingZeros(pokemon.id)
                                Text(formattedID)
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                
                                Text(pokemon.name)
                                    .font(.headline)
                                Pokeball(captured: pokemon.captured, width: 30, height: 30)
                                Spacer()
                                PokemonImage(pokemon: pokemon, frame: (width: 100, height: 100), cornerID: false)
                            }
                        }
                    }
                }
                .navigationTitle("Pokédex")
                .accentColor(.back)
            }

        }
}

#Preview {
    RowView()
        .environment(PokedexManager())
}
