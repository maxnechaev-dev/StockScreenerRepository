//
//  DescriptionCell.swift
//  StockScreener
//
//  Created by Max Nechaev on 14.07.2021.
//

import UIKit

class DescriptionCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 8
        self.clipsToBounds = true
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.10
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 3, height: 5)
        layer.shadowColor = UIColor.black.cgColor
        
        setupLabels()

    }
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = .white

        textView.contentInsetAdjustmentBehavior = .automatic
        textView.textColor = .black
        textView.font = .systemFont(ofSize: 17)
        
        textView.text = "   There exist multiple varieties of apples; they are distinguished by the shape of the fruit, rounded, elongate or flattened; by their colour, that varies from bright red to green; the colour of the pulp, its flavour - there are some apples in which sweetness predominates over acidity and some others, on the contrary, are very acid -; by the texture, that ranges from a very crisp to a mealy texture, although the latter may also be due to a storage problem; the period of maturation, the characteristics of the tree, suitability for storage, behaviour against diseases and pests, etc. Apples also defer in size, as much within the same variety as among varieties; the apples used for cooking are usually bigger than those for fresh consumption."
        
        return textView
    }()
    
    private func setupLabels() {
        addSubview(textView)
        textView.leftAnchor.constraint(equalTo: leftAnchor).isActive = true
        textView.rightAnchor.constraint(equalTo: rightAnchor).isActive = true
        textView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        textView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
