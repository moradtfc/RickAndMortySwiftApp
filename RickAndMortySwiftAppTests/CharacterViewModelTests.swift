import XCTest
import SwiftUI
@testable import RickAndMortySwiftApp

final class CharacterViewModelTests: XCTestCase {
    
    func testLoadCharacterData() {
        
        let viewModel = CharacterViewModel()
        viewModel.loadCharacterData()
        
        let expectation = XCTestExpectation(description: "Load Character Data")
        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
            // Comprobamos que tenemos cargados Personajes de Rick & Morty.
            XCTAssertFalse(viewModel.characters.isEmpty, "Characters should not be empty")
            
            // Comprobamos que hasMorePages sea true.
            XCTAssertTrue(viewModel.hasMorePages, "hasMorePages should be true")
            
            expectation.fulfill()
        }
        
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testGetCircleColor() {
        let characterViewModel = CharacterViewModel()
        
        let aliveStatusColor = characterViewModel.getCircleColor(for: "Alive")
        XCTAssertEqual(aliveStatusColor, Color.green, "The color for 'Alive' status should be green")
        
        let deadStatusColor = characterViewModel.getCircleColor(for: "Dead")
        XCTAssertEqual(deadStatusColor, Color.red, "The color for 'Dead' status should be red")
        
        let unknownStatusColor = characterViewModel.getCircleColor(for: "unknown")
        XCTAssertEqual(unknownStatusColor, Color.gray, "The color for 'unknown' status should be gray")
        
        let otherStatusColor = characterViewModel.getCircleColor(for: "Other")
        XCTAssertEqual(otherStatusColor, Color.gray, "The color for other status should be gray")
    }
    
    func testFilteredCharacters() {
        let characterViewModel = CharacterViewModel()
    
        let character1 = Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", image: "rick.png", gender: "Male", origin: Location(name: "Earth", url: "earth.com"), location: Location(name: "Earth", url: "earth.com"))
        let character2 = Character(id: 2, name: "Morty Smith", status: "Dead", species: "Human", image: "morty.png", gender: "Male", origin: Location(name: "Earth", url: "earth.com"), location: Location(name: "Earth", url: "earth.com"))
        let character3 = Character(id: 3, name: "Summer Smith", status: "Alive", species: "Human", image: "summer.png", gender: "Female", origin: Location(name: "Earth", url: "earth.com"), location: Location(name: "Earth", url: "earth.com"))
        
        characterViewModel.characters = [character1, character2, character3]
        
        characterViewModel.selectedGender = "Male"
        var filteredByGender = characterViewModel.filteredCharacters()
        XCTAssertEqual(filteredByGender.count, 2, "Filtered characters count should be 2 (filtered by gender)")
        
        characterViewModel.selectedGender = "Female"
        filteredByGender = characterViewModel.filteredCharacters()
        XCTAssertEqual(filteredByGender.count, 1, "Filtered characters count should be 1 (filtered by gender)")
        
        characterViewModel.selectedGender = ""
        filteredByGender = characterViewModel.filteredCharacters()
        XCTAssertEqual(filteredByGender.count, 3, "Filtered characters count should be 3 (no gender filter)")
        
        characterViewModel.selectedStatus = "Alive"
        var filteredByStatus = characterViewModel.filteredCharacters()
        XCTAssertEqual(filteredByStatus.count, 2, "Filtered characters count should be 2 (filtered by status)")
        
        characterViewModel.selectedStatus = "Dead"
        filteredByStatus = characterViewModel.filteredCharacters()
        XCTAssertEqual(filteredByStatus.count, 1, "Filtered characters count should be 1 (filtered by status)")
        
        characterViewModel.selectedStatus = ""
        filteredByStatus = characterViewModel.filteredCharacters()
        XCTAssertEqual(filteredByStatus.count, 3, "Filtered characters count should be 3 (no status filter)")
        
        characterViewModel.selectedGender = "Male"
        characterViewModel.selectedStatus = "Alive"
        let filteredByBoth = characterViewModel.filteredCharacters()
        XCTAssertEqual(filteredByBoth.count, 1, "Filtered characters count should be 1 (filtered by both gender and status)")
    }
    
    func testFilteredCharactersName() {
        let characterViewModel = CharacterViewModel()
        
        let character1 = Character(id: 1, name: "Rick Sanchez", status: "Alive", species: "Human", image: "rick.png", gender: "Male", origin: Location(name: "Earth", url: "earth.com"), location: Location(name: "Earth", url: "earth.com"))
        let character2 = Character(id: 2, name: "Morty Smith", status: "Dead", species: "Human", image: "morty.png", gender: "Male", origin: Location(name: "Earth", url: "earth.com"), location: Location(name: "Earth", url: "earth.com"))
        let character3 = Character(id: 3, name: "Summer Smith", status: "Alive", species: "Human", image: "summer.png", gender: "Female", origin: Location(name: "Earth", url: "earth.com"), location: Location(name: "Earth", url: "earth.com"))
        
        characterViewModel.characters = [character1, character2, character3]
        
        let filteredEmptySearch = characterViewModel.filteredCharactersName(for: "")
        XCTAssertEqual(filteredEmptySearch.count, 3, "Filtered characters count should be 3 (empty search text)")
        
        let filteredBySearchText = characterViewModel.filteredCharactersName(for: "Rick")
        XCTAssertEqual(filteredBySearchText.count, 1, "Filtered characters count should be 1 (search text 'Rick')")
        
        let filteredBySearchText2 = characterViewModel.filteredCharactersName(for: "Smith")
        XCTAssertEqual(filteredBySearchText2.count, 2, "Filtered characters count should be 2 (search text 'Smith')")
        
        let filteredBySearchText3 = characterViewModel.filteredCharactersName(for: "Jessica")
        XCTAssertEqual(filteredBySearchText3.count, 0, "Filtered characters count should be 0 (search text 'Jessica')")
    }
    
    func testLoadMoreCharacters() {
        let characterViewModel = CharacterViewModel()
        let initialCurrentPage = characterViewModel.currentPage
        
        characterViewModel.loadMoreCharacters()

        XCTAssertEqual(characterViewModel.currentPage, initialCurrentPage + 1, "currentPage should be incremented by 1")
    }
    
}
