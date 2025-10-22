//
//  ContentView.swift
//  Pokedex
//
//  Created by Alaina Ge on 2025-10-21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack {
//            Image(systemName: "globe")
//                .imageScale(.large)
//                .foregroundStyle(.tint)
//            Text("Hello, world!")
            PokemonsImageView()
        }
        .padding()
    }
}

#Preview {
    ContentView()
}
