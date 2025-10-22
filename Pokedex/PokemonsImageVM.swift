//
//  PokemonsImageVM.swift
//  Pokedex
//
//  Created by Alaina Ge on 2025-10-21.
//
import SwiftUI

@Observable @MainActor
class PokemonsImageVM {

    var currentPokemon: (name: String, imageUrl: String)?

    var pokemons: [(name: String, imageUrl: String)] = []

    private var offset = 0
    private var limit = 20

    func pokemonTapped(selected: (name: String, imageUrl: String)) {
        currentPokemon = selected
    }

    func fetchPokemons() async {
        let urlLink = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(limit)&offset=\(offset)")!
        do {
            let (data, _) = try await URLSession.shared.data(from: urlLink)
            let decodedList = try JSONDecoder().decode(PokemonListResponse.self, from: data)

            await withTaskGroup(of: (String, String)?.self) { group in
                for item in decodedList.results {
                    group.addTask {
                        if let details = await self.fetchPokemonDetail(from: item.url),
                           let imageUrl = details.sprites.front_default {
                                return (item.name.capitalized, imageUrl)
                        }
                        return nil
                    }
                }

                for await result in group {
                    if let pokemon = result {
                        self.pokemons.append(pokemon)
                    }
                }
            }
            print("increment offset")
            offset += limit

        } catch {
            print("Error fetching Pokemon list: \(error)")
        }
    }

    private func fetchPokemonDetail(from urlString: String) async -> PokemonDetail? {
        guard let url = URL(string: urlString) else { return nil }
        do {
            let (data, _) = try await URLSession.shared.data(from: url)
            return try JSONDecoder().decode(PokemonDetail.self, from: data)
        } catch {
            print("Error fetching details: \(error)")
            return nil
        }
    }
}
