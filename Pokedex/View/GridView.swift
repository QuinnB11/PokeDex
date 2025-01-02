//
//  GridView.swift
//  Pokedex
//
//  Created by Quinn Butcher on 11/3/24.
//

import SwiftUI
  
    
struct GridView: View {
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
    
    let columns: [GridItem] = [GridItem(.adaptive(minimum: 100))]
    var capturedPokemons: [Pokemon] {
        pokedexManager.pokedex.filter { $0.captured == true }
    }
    
    var uncapturedPokemons: [Pokemon] {
        filteredPokemon.filter { $0.captured == false }
    }
    var uncapturedByType: [PokemonType: [Pokemon]] {
        var typeToPokemons: [PokemonType: [Pokemon]] = [:]
        
        for pokemon in uncapturedPokemons {
            for type in pokemon.types {
                guard type != .none else { continue }
                typeToPokemons[type, default: []].append(pokemon)
            }
        }
        
        return typeToPokemons
    }
    
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if !capturedPokemons.isEmpty {
                        Section(header: Text("Captured Pokémon").font(.headline)) {
                            LazyVGrid(columns: columns, spacing: 20) {
                                ForEach(capturedPokemons) { pokemon in
                                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                        CardView(pokemon: pokemon, height: 100, width: 100)
                                    }
                                }
                            }
                        }
                    }
                    VStack {
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
                        if !uncapturedPokemons.isEmpty {
                            Section(header: Text("Uncaptured Pokémon").font(.headline)) {
                                ForEach(PokemonType.allCases.filter { $0 != .none }, id: \.self) { type in
                                    if let pokemonsOfType = uncapturedByType[type], !pokemonsOfType.isEmpty {
                                        Section(header:
                                                    Text(type.rawValue)
                                                        .font(.headline)
                                                        .padding()
                                                        .background(Color(pokemonType: type))
                                                        .cornerRadius(9)
                                                        .shadow(radius: 3)) {
                                            LazyVGrid(columns: columns, spacing: 20) {
                                                ForEach(pokemonsOfType) { pokemon in
                                                    NavigationLink(destination: PokemonDetailView(pokemon: pokemon)) {
                                                        CardView(pokemon: pokemon, height: 100, width: 100)
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("Pokédex")
        }
    }
}
                                          
                                            
                                        
#Preview {
    GridView()
        .environment(PokedexManager())
}
