//
//  CharacterListFactory.swift
//  RickAndMorty
//
//  Created by Thiago Leite on 29/07/23.
//

import UIKit

struct CharacterListFactory {
    static func build() -> UIViewController {
        let controller = CharacterListViewController()
        let presenter = CharacterListPresenter(controller: controller)
        let interactor = CharacterListInteractor(presenter: presenter)
        
        controller.interactor = interactor
        
        return controller
    }
}
