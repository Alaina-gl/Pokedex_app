//
//  PokemonModel.swift
//  Pokedex
//
//  Created by Alaina Ge on 2025-10-21.
//

import Foundation

struct PokemonListResponse: Codable {
    let results: [PokemonListItem]
}

struct PokemonListItem: Codable, Identifiable {
    let name: String
    let url: String

    var id: String { name } // for SwiftUI List/ForEach
}

struct PokemonDetail: Codable {
    let sprites: Sprites
}

struct Sprites: Codable {
    let front_default: String?
}
