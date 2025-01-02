//
//  NumberView.swift
//  Pokedex
//
//  Created by Quinn Butcher on 10/28/24.
//

import SwiftUI

struct NumberView: View {
    let value : String
    let number: Double
    let caption : String
    var body: some View {
        VStack(spacing: 0) {
            Text("\(value):")
                .font(.title)
                .fontWeight(.bold)
            HStack(spacing: 0) {
                Text("\(number, specifier: "%.2f")")
                    .font(.title)
                    .fontWeight(.bold)

                Text(caption)
                    .font(.caption)
                    .foregroundColor(.secondary)

            }
        }
    }
}

#Preview {
    NumberView(value: "Height", number: 2.0, caption: "m")
}
