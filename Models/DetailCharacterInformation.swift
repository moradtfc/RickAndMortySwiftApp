//
//  DetailCharacterInformation.swift
//  RickAndMortySwiftApp
//
//  Created by Jesus Mora on 3/6/23.
//

import Foundation

struct DetailCharacterInformation {
   
    let character: Character
   
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

