//
//  CharacterPresenter.swift
//  RickAndMorty
//
//  Created by Thiago Leite on 27/07/23.
//

import UIKit

protocol CharacterListViewPresenterProtocol: AnyObject {
    func loadInitialCharacters(characters: [CharacterModel])
}

final class CharacterListPresenter: NSObject {
    
    private weak var controller: CharacterListViewControllerProtocol?
    
    init(controller: CharacterListViewControllerProtocol?) {
        self.controller = controller
    }
    
    private var characters: [CharacterModel] = []
      
    private var cellPresenters: [CharacterCollectionViewCellPresenter] = []
    
    private var apiInfo: GetAllCharactersResponse.Info? = nil
   
}

// MARK: - CollectionView

extension CharacterListPresenter: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellPresenters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: CharacterCollectionViewCell.cellIdentifier,
            for: indexPath
        ) as? CharacterCollectionViewCell else {
            fatalError("Unsupported cell")
        }
        cell.configure(with: cellPresenters[indexPath.row])
        return cell
    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
    
            return CGSize(width: collectionView.frame.width,
                          height: 100)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = collectionView.bounds
        let width: CGFloat = (bounds.width-30)/2
        
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        
    }
}

extension CharacterListPresenter: CharacterListViewPresenterProtocol {
    func loadInitialCharacters(characters: [CharacterModel]) {
        controller?.showCharacterList()
    }  
}
