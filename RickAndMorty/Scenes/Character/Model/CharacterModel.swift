//
//  Character.swift
//  RickAndMorty
//
//  Created by Thiago Almeida Leite on 02/01/23.
//

import Foundation

struct CharacterModel: Codable {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let type: String
    let gender: RMCharacterGender
    let origin: RMOrigin
    let location: RMSingleLocation
    let image: String
    let episode: [String]
    let url: String
    let created: String
}
