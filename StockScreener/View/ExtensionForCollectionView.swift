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
        
        //Сделать изменение цены красной при минусе, зеленой при плюсе
        if element.change > 0 {
            cell.companyChangePrice.textColor = .green
        } else { cell.companyChangePrice.textColor = .red }
        
        //Округление до двух знаков после запятой
        let elementChange = element.change
        var elementChangeString: String {
            return String(format: "%.2f", elementChange)
        }
        
        let elementChangePercent = element.changePercent * 100
        var elementChangePercentString: String {
            return String(format: "%.2f", elementChangePercent)
        }
        
        cell.companyChangePrice.text = "\(elementChangeString) (\(elementChangePercentString)%)"
        
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
