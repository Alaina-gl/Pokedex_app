//
//  PokemonsImageView.swift
//  Pokedex
//
//  Created by Alaina Ge on 2025-10-21.
//

import SwiftUI
import Kingfisher

struct PokemonsImageView: View {

    let columns = [GridItem(.adaptive(minimum: 90), spacing: 16)]

    @State var viewModel = PokemonsImageVM()

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
    private var currentImage: some View {
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
            ForEach(Array(viewModel.pokemons.enumerated()), id: \.offset) { _, pokemon in
                VStack {
                    KFImage(URL(string: pokemon.imageUrl))
                        .resizable()
                        .scaledToFit()
                    Text(pokemon.name)
                        .font(.caption)
                        .fontWeight(.semibold)
                }
                .frame(maxWidth: .infinity)
                .frame(maxHeight: .infinity)
                .padding()
                .background(viewModel.currentPokemon?.imageUrl == pokemon.imageUrl ? Color(.systemGray4) : Color(.systemGray6))
                .cornerRadius(12)
                .shadow(radius: 2)
                .onTapGesture {
                    viewModel.pokemonTapped(selected: pokemon)
                    print("tapped pokemon: \(pokemon.name)")
                }
                .onAppear {
                    // start loading when loading the last 3 pokemons requested
                    if viewModel.pokemons.count >= 3, pokemon == viewModel.pokemons[viewModel.pokemons.count - 3] {
                        Task {
                            print("fetching pokemons")
                            await viewModel.fetchPokemons()
                        }
                    }
                }
            }
        }
        .padding()
    }
}

#Preview {
    PokemonsImageView()
}
