//
//  PokemonsImageVM.swift
//  Pokedex
//
//  Created by Alaina Ge on 2025-10-21.
//
import SwiftUI

@Observable @MainActor
class PokemonsImageVM {

    var url: String

    var currentPokemonImage: Image?

    var pokemons: [(name: String, imageUrl: String)] = []

    init(url: String) {
        self.url = url
    }

    func fetchPokemons() async {
        let urlLink = URL(string: url)!
        do {
            let (data, _) = try await URLSession.shared.data(from: urlLink)
            let decodedList = try JSONDecoder().decode(PokemonListResponse.self, from: data)

            for item in decodedList.results {
                if let details = await fetchPokemonDetail(from: item.url) {
                    if let imageUrl = details.sprites.front_default {
                        pokemons.append((item.name.capitalized, imageUrl))
                    }
                }
            }
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
