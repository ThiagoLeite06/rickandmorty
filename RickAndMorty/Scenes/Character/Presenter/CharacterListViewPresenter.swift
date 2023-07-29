//
//  CharacterPresenter.swift
//  RickAndMorty
//
//  Created by Thiago Leite on 27/07/23.
//

import UIKit

protocol CharacterListViewPresenterDelegate: AnyObject {
    func didLoadInitialCharacters()
    //    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    //
    //    func didSelectCharacter(_ character: Character)
}

final class CharacterListViewPresenter: NSObject {
    
    private var isLoadingMoreCharacters = false
    
    public weak var delegate: CharacterListViewPresenterDelegate?
    
    private var characters: [CharacterModel] = [] {
        didSet {
            for character in characters {
                let presenter = CharacterCollectionViewCellPresenter(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageUrl: URL(string: character.image)
                )
                if !cellPresenters.contains(presenter) {
                    cellPresenters.append(presenter)
                }
            }
        }
    }
    
    private var cellPresenters: [CharacterCollectionViewCellPresenter] = []
    
    private var apiInfo: GetAllCharactersResponse.Info? = nil
    
    /// Fetch initial set of characters (20)
    public func fetchCharacters() {
        RMService.shared.execute(
            .listCharactersRequests,
            expecting: GetAllCharactersResponse.self
        ) { [weak self] result in
            switch result {
            case .success(let responseModel):
                let results = responseModel.results
                let info = responseModel.info
                self?.characters = results
                self?.apiInfo = info
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
}

// MARK: - CollectionView

extension CharacterListViewPresenter: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout
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
    
    //    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
    //        guard kind == UICollectionView.elementKindSectionFooter,
    //              let footer = collectionView.dequeueReusableSupplementaryView(
    //                ofKind: kind,
    //                withReuseIdentifier: RMFooterLoadingCollectionReusableView.identifier,
    //                for: indexPath
    //              ) as? RMFooterLoadingCollectionReusableView else {
    //            fatalError("Unsupported")
    //        }
    //        footer.startAnimating()
    //        return footer
    //    }
    
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
//            guard shouldShowLoadMoreIndicator else {
//                return .zero
//            }
    
            return CGSize(width: collectionView.frame.width,
                          height: 100)
        }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let bounds = collectionView.bounds
        let width: CGFloat = (bounds.width-30)/2
        // mac | ipad
        //width = (bounds.width-50)/4
        
        return CGSize(
            width: width,
            height: width * 1.5
        )
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        let character = characters[indexPath.row]
        //        delegate?.didSelectCharacter(character)
    }
}

// MARK: - ScrollView
extension CharacterListViewPresenter: UIScrollViewDelegate {
    //    func scrollViewDidScroll(_ scrollView: UIScrollView) {
    //        guard shouldShowLoadMoreIndicator,
    //              !isLoadingMoreCharacters,
    //              !cellPresenters.isEmpty,
    //              let nextUrlString = apiInfo?.next,
    //              let url = URL(string: nextUrlString) else {
    //            return
    //        }
    //        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
    //            let offset = scrollView.contentOffset.y
    //            let totalContentHeight = scrollView.contentSize.height
    //            let totalScrollViewFixedHeight = scrollView.frame.size.height
    //
    //            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
    //                self?.fetchAdditionalCharacters(url: url)
    //            }
    //            t.invalidate()
    //        }
    //    }
}
