//
//  CharacterInteractor.swift
//  RickAndMorty
//
//  Created by Thiago Leite on 27/07/23.
//

import UIKit

protocol CharacterListInteractorProtocol: AnyObject {
    func fetchCharacters()
}

final class CharacterListInteractor: NSObject {
    
    weak var presenter: CharacterListViewPresenterProtocol?
    
    private var mock = Mock()
    
    private var characters: [CharacterModel] = []
    
    init(presenter: CharacterListViewPresenterProtocol?) {
        self.presenter = presenter
    }
    
}

extension CharacterListInteractor: CharacterListInteractorProtocol {
    func fetchCharacters() {
        //
    }
}

