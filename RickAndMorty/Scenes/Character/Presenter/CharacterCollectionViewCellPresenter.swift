//
//  CharacterCollectionViewCellPresenter.swift
//  RickAndMorty
//
//  Created by Thiago Leite on 28/07/23.
//

import UIKit


final class CharacterCollectionViewCellPresenter: Hashable, Equatable {
    public let characterName: String
    private let characterStatus: CharacterStatus
    private let characterImageUrl: URL?
    
    // MARK: - Init
    
    init(
        characterName: String,
        characterStatus: CharacterStatus,
        characterImageUrl: URL?
    ) {
        self.characterName = characterName
        self.characterStatus = characterStatus
        self.characterImageUrl = characterImageUrl
    }
    
    public var characterStatusText: String {
           return "Status: \(characterStatus.text)"
       }

       public func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
          
           guard let url = characterImageUrl else {
               completion(.failure(URLError(.badURL)))
               return
           }
//           RMImageLoader.shared.downloadImage(url, completion: completion)
       }

       // MARK: - Hashable

       static func == (lhs: CharacterCollectionViewCellPresenter, rhs: CharacterCollectionViewCellPresenter) -> Bool {
           return lhs.hashValue == rhs.hashValue
       }

       func hash(into hasher: inout Hasher) {
           hasher.combine(characterName)
           hasher.combine(characterStatus)
           hasher.combine(characterImageUrl)
       }
}

