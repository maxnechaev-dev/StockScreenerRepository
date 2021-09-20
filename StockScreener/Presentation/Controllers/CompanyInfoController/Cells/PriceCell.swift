//
//  PriceCell.swift
//  StockScreener
//
//  Created by Max Nechaev on 14.07.2021.
//

import UIKit

class PriceCell: UICollectionViewCell {
    
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
    
    let companyLogo: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        //imageView.image = UIImage(named: "appleLogoBlack")
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    let symbol: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = .white
        label.text = "SMBL"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 25)
        
        return label
    }()
    
    let price: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = .white
        label.text = "1898.97 $"
        label.textAlignment = .left
        label.font = .boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private func setupLabels() {
        
        addSubview(companyLogo)
        companyLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        companyLogo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        companyLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        companyLogo.widthAnchor.constraint(equalTo: companyLogo.heightAnchor, multiplier: 1.0).isActive = true
        
        addSubview(symbol)
        symbol.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        symbol.leftAnchor.constraint(equalTo: companyLogo.rightAnchor, constant: 10).isActive = true
        symbol.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        addSubview(price)
        price.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        price.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        price.heightAnchor.constraint(equalToConstant: 40).isActive = true
   
    }

    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
