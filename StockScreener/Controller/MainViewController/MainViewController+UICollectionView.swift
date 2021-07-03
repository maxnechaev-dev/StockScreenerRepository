//
//  CollectionViewFirstScreen.swift
//  StockScreener
//
//  Created by Max Nechaev on 12.06.2021.
//

import UIKit


//MARK: - extension UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
}

//MARK: - extension UICollectionViewDataSource

extension MainViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        2
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        var identifier = "trendingCellID"
        
        if indexPath.item == 1 {
            identifier = "favouriteCellID"
        }
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        
        if let trendingCell = cell as? TrendingStockCell {
            trendingCell.delegate = self
        }
        
        if let favouriteCell = cell as? FavouriteStockCell {
            favouriteCell.delegate = self
            favouriteCell.load()
        }
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        menuBar.horizontalBarAnchor?.constant = scrollView.contentOffset.x / 2
    }
}

//MARK: - extension UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height - (165))
    }
    
}
