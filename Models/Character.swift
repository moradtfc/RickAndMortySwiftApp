import Foundation


struct Character: Codable, Identifiable, Equatable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let image: String
    let gender: String
    let origin, location: Location

    static func ==(lhs: Character, rhs: Character) -> Bool {
        return lhs.id == rhs.id
    }
}


struct Results: Codable {
    let info: Info
    let results: [Character]
}

struct Location: Codable {
    let name: String
    let url: String
}

struct Info: Codable{
    let count: Int
    let pages: Int
    let next: String
    let prev: String?
}
