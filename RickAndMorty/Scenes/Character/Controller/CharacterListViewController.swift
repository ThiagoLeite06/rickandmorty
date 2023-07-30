//
//  CharacterViewController.swift
//  RickAndMorty
//
//  Created by Thiago Almeida Leite on 02/01/23.
//

import UIKit

protocol CharacterListViewControllerProtocol: NSObject {
    func showCharacterList()
}

final class CharacterListViewController: UIViewController {
    
    private let characterListView = CharacterListView()
    
    private var interactor: CharacterListInteractorProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        title = "Character"
        setUpView()
        config()
        interactor?.loadCharacters()
   
    }
    
    private func config() {
        let presenter = CharacterListPresenter(controller: self)
        self.interactor = CharacterListInteractor(presenter: presenter)
    }
    
    private func setUpView() {
        view.addSubview(characterListView)
        NSLayoutConstraint.activate([
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            characterListView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ])
    }
    
}

extension CharacterListViewController: CharacterListViewControllerProtocol {
    func showCharacterList() {
//        characterListView.collectionView.reloadData()
//        characterListView.collectionView.isHidden = false
//        characterListView.spinner.stopAnimating()
    }
}
