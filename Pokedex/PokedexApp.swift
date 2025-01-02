//
//  PokedexApp.swift
//  Pokedex
//
//  Created by Quinn Butcher on 10/28/24.
//

import SwiftUI

@main
struct PokedexApp: App {
    @State private var pokedexManager = PokedexManager()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(pokedexManager)
        }
    }
}
