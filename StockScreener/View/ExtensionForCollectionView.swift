//
//  CollectionViewFirstScreen.swift
//  StockScreener
//
//  Created by Max Nechaev on 12.06.2021.
//

import UIKit

//класс для того, чтобы поместить сюда настройку collection, не получилось
class SetupCollectionView: MainViewController {

    
}

//MARK: - extension UICollectionViewDelegate, UICollectionViewDataSource

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        return mostActive?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CustomCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 9
        
        guard let element = mostActive?[indexPath.row] else { return cell }
        cell.companyTicker.text = element.symbol
        cell.companyName.text = element.companyName
        cell.companyPrice.text = "\(element.iexRealtimePrice)"
        cell.companyChangePrice.text = "\(element.change) (\(element.changePercent * 100)%)"
        
        return cell
    }
}

//MARK: - extension UICollectionViewDelegateFlowLayout

extension MainViewController: UICollectionViewDelegateFlowLayout {

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let itemsPerRow: CGFloat = 1
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    }
}
