//
//  PokemonsImageView.swift
//  Pokedex
//
//  Created by Alaina Ge on 2025-10-21.
//

import SwiftUI

struct PokemonsImageView: View {

    private enum Constants {
        static let imageURL = "https://pokeapi.co/api/v2/pokemon?limit=20&offset=10"
    }
    
    let columns = [GridItem(.adaptive(minimum: 90), spacing: 16)]

    @State var viewModel = PokemonsImageVM(url: Constants.imageURL)

    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    if let topImage = viewModel.currentPokemonImage {
                        // TODO: add current image selection functionalities
                    }
                    pokemonsGrid
                }
            }
            .navigationTitle("Pokemon")
            .task {
                await viewModel.fetchPokemons()
            }
        }
    }

    private var pokemonsGrid: some View {
        LazyVGrid(columns: columns, spacing: 16) {
            ForEach(viewModel.pokemons, id: \.name) { pokemon in
                VStack {
                    AsyncImage(url: URL(string: pokemon.imageUrl)) { image in
                        image
                            .resizable()
                            .scaledToFit()
                    } placeholder: {
                        ProgressView()
                    }
                    Text(pokemon.name)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .padding()
                .background(Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 2)
            }
        }
        .padding()
    }
}

#Preview {
    PokemonsImageView()
}
