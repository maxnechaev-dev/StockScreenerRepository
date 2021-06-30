//
//  CollectionViewFirstScreen.swift
//  StockScreener
//
//  Created by Max Nechaev on 12.06.2021.
//

import UIKit


//MARK: - extension UICollectionViewDelegate

extension MainViewController: UICollectionViewDelegate {
    
    
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//
//        guard let models = mostActive else { return }
//        let model = models[indexPath.row]
//
//        let infoViewController = InfoViewController(model: model)
//        navigationController?.pushViewController(infoViewController, animated: true)
//    }
    
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
