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
                    currentImage
                    pokemonsGrid
                }
            }
            .navigationTitle(pokemonTitle)
            .task {
                await viewModel.fetchPokemons()
            }
        }
    }

    private var pokemonTitle: String {
        if let pokemon = viewModel.currentPokemon {
            return pokemon.name
        } else {
            return "Pokemon"
        }
    }

    @ViewBuilder
    private var currentImage : some View {
        if let imageUrl = viewModel.currentPokemon?.imageUrl {
            AsyncImage(url: URL(string: imageUrl)) { image in
                image
                    .resizable()
                    .scaledToFit()
                    .frame(height: 300)
            } placeholder: {
                ProgressView()
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
                .onTapGesture {
                    viewModel.pokemonTapped(selected: pokemon)
                    print("tapped pokemon: \(pokemon.name)")
                }
            }
        }
        .padding()
    }
}

#Preview {
    PokemonsImageView()
}
