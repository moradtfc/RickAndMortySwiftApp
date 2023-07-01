import Foundation
import SwiftUI
import Combine

class CharacterViewModel: ObservableObject {
    let filters: [Filter]
    @Published var characters: [Character] = []
    @Published var selectedGender: String = ""
    @Published var selectedStatus: String = ""
    @Published var favoriteCharacters: [Character] = []
    private var cancellables = Set<AnyCancellable>()
    var nextPageURL: String?
    
    init() {
        filters = [
            Filter(title: "Gender", options: ["", "Male", "Female", "Genderless", "Unknown"]),
            Filter(title: "Status", options: ["", "Alive", "Dead", "Unknown"])
        ]
        loadCharacterData()
        loadFavoritePlanets()
    }
    
    func loadCharacterData() {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character") else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Results.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] response in
                self?.characters = response.results
                self?.nextPageURL = response.info.next
                self?.loadFavoritePlanets()
            }
            .store(in: &cancellables)
        
        
    }
    
    func loadMoreCharacters() {
        guard let nextPageURL = nextPageURL, let url=URL(string: nextPageURL) else {
            return
        }
        
        URLSession.shared.dataTaskPublisher(for: url)
            .map { $0.data }
            .decode(type: Results.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .sink { completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    print("Error: \(error)")
                }
            } receiveValue: { [weak self] response in
                self?.characters.append(contentsOf: response.results)
                self?.nextPageURL = response.info.next
            }
            .store(in: &cancellables)
        
    }
    
    func getCircleColor(for status: String) -> Color {
        switch status {
        case "Alive":
            return Color.green
        case "Dead":
            return Color.red
        case "unknown":
            return Color.gray
        default:
            return Color.gray
        }
    }
    
    func filteredCharacters() -> [Character] {
        var filteredCharacters = characters
        
        if !selectedGender.isEmpty {
            filteredCharacters = filteredCharacters.filter { $0.gender == selectedGender }
        }
        
        if !selectedStatus.isEmpty {
            filteredCharacters = filteredCharacters.filter { $0.status == selectedStatus }
        }
        
        return filteredCharacters
    }
    
    func getGenderOptions() -> [String] {
        filters.first(where: { $0.title == "Gender" })?.options ?? []
    }
    
    func getStatusOptions() -> [String] {
        filters.first(where: { $0.title == "Status" })?.options ?? []
    }
    
    //Filtro para las búsquedas de personajes por nombre
    func filteredCharactersName(for searchText: String) -> [Character] {
        if searchText.isEmpty {
            return characters
        } else {
            return characters.filter { $0.name.contains(searchText) }
        }
    }
    
    func toggleFavorite(character: Character) {
        if favoriteCharacters.contains(where: { $0.name == character.name }) {
            favoriteCharacters.removeAll(where: { $0.name == character.name })
            UserDefaults.standard.set(favoriteCharacters.map { $0.name }, forKey: "FavoriteCharacters")
            
        } else {
            favoriteCharacters.append(character)
            UserDefaults.standard.set(favoriteCharacters.map { $0.name }, forKey: "FavoriteCharacters")
            
        }
    }
    
    func favoriteButtonLabel(for character: Character) -> String {
        return favoriteCharacters.contains { $0.name == character.name } ? "Remover de Favoritos" : "Agregar a Favoritos"
    }
    
    func backgroundButtonLabel(for character: Character) -> Bool {
        
        return favoriteCharacters.contains { $0.name == character.name } ? true : false
        
    }
    
    func loadFavoritePlanets() {
        var favoritedCharacterNames = UserDefaults.standard.array(forKey: "FavoriteCharacters") as? [String] ?? []
        
        favoriteCharacters = characters.filter { character in
            favoritedCharacterNames.contains(character.name)
        }
    }
    
}

