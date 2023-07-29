//
//  GetAllCharactersResponse.swift
//  RickAndMorty
//
//  Created by Thiago Almeida Leite on 07/01/23.
//

import Foundation

struct GetAllCharactersResponse: Codable {
    struct Info: Codable {
        let count: Int
        let pages: Int
        let next: String?
        let prev: String?
    }

    let info: Info
    let results: [CharacterModel]
}
