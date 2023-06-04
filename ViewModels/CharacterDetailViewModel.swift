import Foundation

class CharacterDetailViewModel: ObservableObject {
    let character: Character
    let characterViewModel: CharacterViewModel
    
    init(character: Character, characterViewModel: CharacterViewModel) {
        self.character = character
        self.characterViewModel = characterViewModel
    }
    
    struct DetailItem: Identifiable {
        let id = UUID()
        let title: String
        let value: String
    }
    
    var details: [DetailItem] {
        [
            DetailItem(title: "Name:", value: character.name),
            DetailItem(title: "Status:", value: character.status),
            DetailItem(title: "Species:", value: character.species),
            DetailItem(title: "Gender:", value: character.gender),
            DetailItem(title: "Origin:", value: character.origin.name),
            DetailItem(title: "Location:", value: character.location.name)
        ]
    }
    
}
