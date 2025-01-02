//
//  Pokeball.swift
//  Pokedex
//
//  Created by Quinn Butcher on 11/4/24.
//

import SwiftUI

struct Pokeball: View {
    let captured : Bool
    let width: CGFloat
    let height: CGFloat
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: width-3, height: height-3)
            Image(captured == true ? "captured" : "uncaptured")
                .resizable()
                .scaledToFill()
                .frame(width: width, height: height)
                .clipShape(Circle())
        }
    }
}

