//
//  CharacterInteractor.swift
//  RickAndMorty
//
//  Created by Thiago Leite on 27/07/23.
//

import UIKit

protocol CharacterListInteractorProtocol: AnyObject {
    func loadCharacters()
}

final class CharacterListInteractor: NSObject {
    
    weak var presenter: CharacterListViewPresenterProtocol?
    
    private var characters: [CharacterModel] = []
    
    init(presenter: CharacterListViewPresenterProtocol?) {
        self.presenter = presenter
    }
    
    
    private func fetchCharacters() {
        let apiURLString = "https://rickandmortyapi.com/api/character"
        
        Task.init(operation: {
            do {
                let characters = try await fetchData(from: apiURLString)
                print(characters)
                self.characters = characters.results
                presenter?.loadInitialCharacters(characters: self.characters)
            } catch {
                print("Error fetching data: \(error)")
            }
        })
    }
    
    private func fetchData(from urlString: String) async throws -> GetAllCharactersResponse {
        let url = URL(string: urlString)!
        let (data, _) = try await URLSession.shared.data(from: url)
        let decoder = JSONDecoder()
        let characters = try decoder.decode(GetAllCharactersResponse.self, from: data)
        return characters
    }
    
}

extension CharacterListInteractor: CharacterListInteractorProtocol {
    func loadCharacters() {
        fetchCharacters()
    }
}

