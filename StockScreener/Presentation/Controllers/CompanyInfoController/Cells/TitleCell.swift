//
//  TitleCell.swift
//  StockScreener
//
//  Created by Max Nechaev on 14.07.2021.
//

import UIKit

class TitleCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        layer.cornerRadius = 8
        self.clipsToBounds = true
        
        layer.masksToBounds = false
        layer.shadowOpacity = 0.10
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 3, height: 5)
        layer.shadowColor = UIColor.black.cgColor

        setupLabels()
    }
    
    let mainTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = .black
        label.text = "Name of the Company"
        label.textAlignment = .center
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    let industryLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Industry of the Company"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 15)
        
        return label
    }()
    
    
    private func setupLabels() {
        addSubview(mainTitle)
        mainTitle.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        mainTitle.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        mainTitle.widthAnchor.constraint(equalToConstant: 300).isActive = true
        mainTitle.heightAnchor.constraint(equalToConstant: 22).isActive = true
        
        addSubview(industryLabel)
        industryLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        industryLabel.topAnchor.constraint(equalTo: mainTitle.bottomAnchor, constant: 0).isActive = true
        industryLabel.widthAnchor.constraint(equalToConstant: 300).isActive = true
        industryLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
