import Foundation
import SwiftUI

class CharacterViewModel: ObservableObject {
    let filters: [Filter]
    @Published var characters: [Character] = []
    @Published var selectedGender: String = ""
    @Published var selectedStatus: String = ""
    @Published var currentPage = 1
    @Published var hasMorePages = true
    
    
    init() {
        filters = [
            Filter(title: "Gender", options: ["", "Male", "Female", "Genderless", "Unknown"]),
            Filter(title: "Status", options: ["", "Alive", "Dead", "Unknown"])
        ]
        loadCharacterData()
    }
    
    func loadCharacterData() {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character?page=\(currentPage)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            
            do {
                let results = try JSONDecoder().decode(Results.self, from: data)
                DispatchQueue.main.async {
                    self.characters = results.results
                    self.hasMorePages = results.info.next != nil
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }.resume()
    }
    
    func loadMoreCharacters() {
        if !hasMorePages {
            return
        }
        
        currentPage += 1
        loadCharacterData()
        
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
    
}
