//
//  ContentView.swift
//  Pokedex
//
//  Created by Quinn Butcher on 10/28/24.
//

import SwiftUI

struct ContentView: View {
    @Environment(PokedexManager.self) var pokedexManager : PokedexManager
    
    
    var body: some View {
            TabView{
                GridView()
                    .tabItem {
                        Label("Grid", systemImage: "square.grid.2x2.fill")
                    }
                    
                RowView()
                    .tabItem {
                        Label("List", systemImage: "list.star")
                    }
            }
        }
}

#Preview {
    ContentView()
        .environment(PokedexManager())
}
