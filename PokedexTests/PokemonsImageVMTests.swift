//
//  PokemonsImageVMTests.swift
//  PokedexTests
//
//  Created by Alaina Ge on 2025-10-23.
//

import XCTest
@testable import Pokedex

@MainActor
final class PokemonsImageVMTests: XCTestCase {

    var viewModel: PokemonsImageVM!

    override func setUp() {
        super.setUp()
        viewModel = PokemonsImageVM()
    }

    override func tearDown() {
        viewModel = nil
        super.tearDown()
    }

    func testPokemonTappedUpdatesCurrentPokemon() {
        let testPokemon = (name: "Pikachu", imageUrl: "https://example.com/pikachu.png")
        viewModel.pokemonTapped(selected: testPokemon)

        XCTAssertEqual(viewModel.currentPokemon?.name, "Pikachu")
        XCTAssertEqual(viewModel.currentPokemon?.imageUrl, "https://example.com/pikachu.png")
    }

    func testFetchPokemonsIncrementsOffset() async {
        let initialOffset = viewModel.offset
        await viewModel.fetchPokemons()
        let newOffset = viewModel.offset

        XCTAssertTrue(newOffset > initialOffset, "Offset should increment after fetch")
    }

    func testFetchPokemonsAppendsResults() async {
        await viewModel.fetchPokemons()
        XCTAssertFalse(viewModel.pokemons.isEmpty, "Pokemons should not be empty after fetch")
        XCTAssertGreaterThan(viewModel.pokemons.count, 0)
    }
}
