//
//  CustomCell.swift
//  StockScreener
//
//  Created by Max Nechaev on 12.06.2021.
//

import UIKit

class CustomCell: UICollectionViewCell {
    static let cellId = "CustomCellId"
	var onFavoriteChane: ((_ isFavorite: Bool) -> Void)?

    // Логотип компании
    let companyLogo: UIImageView = {
        let cl = UIImageView()
        cl.translatesAutoresizingMaskIntoConstraints = false
        cl.contentMode = .scaleAspectFit
        cl.clipsToBounds = true
        //cl.backgroundColor = .black
        //cl.image = UIImage(named: "appleLogoBlack")
        cl.layer.cornerRadius = 12
        return cl
    }()
    
    // Тикер компании
    let companyTicker: UILabel = {
        let ct = UILabel()
        ct.translatesAutoresizingMaskIntoConstraints = false
        ct.text = ""
        ct.font = UIFont.boldSystemFont(ofSize: 18)
        //ct.backgroundColor = .yellow
        return ct
    }()
    
    // Полное название компании
    let companyName: UILabel = {
        let cn = UILabel()
        cn.translatesAutoresizingMaskIntoConstraints = false
        cn.text = ""
        cn.font = UIFont.systemFont(ofSize: 12)
        //cn.backgroundColor = .yellow
        return cn
    }()
    
    //Цена компании (цена за одну акцию)
    let companyPrice: UILabel = {
        let cp = UILabel()
        cp.translatesAutoresizingMaskIntoConstraints = false
        cp.text = "135.65"
        cp.font = UIFont.boldSystemFont(ofSize: 16)
        //cp.backgroundColor = .red
        return cp
    }()
    
    //Изменение цены за определенный период
    let companyChangePrice: UILabel = {
        let ccp = UILabel()
        ccp.translatesAutoresizingMaskIntoConstraints = false
        ccp.text = "+0.13 (1.14%)"
        ccp.font = UIFont.systemFont(ofSize: 12)
        //ccp.backgroundColor = .red
        return ccp
    }()
    
    //Изменение цены за определенный период
    let favoriteStock: UIButton = {
        let star = UIButton(type: .system)
        star.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "starNew")
        star.imageView?.contentMode = .scaleAspectFit
        star.setImage(image, for: .normal)
        star.tintColor = .lightGray

        return star
    }()
    
    //Размещение объектов на contentView
    override init(frame: CGRect) {
        super.init(frame: .zero)
                
        layer.masksToBounds = false
        layer.shadowOpacity = 0.10
        layer.shadowRadius = 4
        layer.shadowOffset = CGSize(width: 3, height: 5)
        layer.shadowColor = UIColor.black.cgColor
        
        positionCompanyLogo()
        positionCompanyTicker()
        positionCompanyName()
        positionCompanyPrice()
        positionCompanyChangePrice()
        positionFavoriteStock()
        
        favoriteStock.addTarget(self, action: #selector(addFavorite), for: .touchUpInside)

    }

	required init?(coder: NSCoder) {
	 fatalError("init(coder:) has not been implemented")
	}

    //MARK: - Доделать изменение цвета кнопки
    @objc func addFavorite (sender: UIButton){

        if favoriteStock.tintColor == .lightGray {
            favoriteStock.tintColor = .orange
			onFavoriteChane?(true)
        } else if favoriteStock.tintColor == .orange {
			onFavoriteChane?(false)
            favoriteStock.tintColor = .lightGray
        }
    }
    
    func positionCompanyLogo() {
        contentView.addSubview(companyLogo)
        companyLogo.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        companyLogo.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10).isActive = true
        companyLogo.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10).isActive = true
        companyLogo.widthAnchor.constraint(equalTo: companyLogo.heightAnchor, multiplier: 1.0).isActive = true
    }
    
    func positionCompanyTicker() {
        contentView.addSubview(companyTicker)
        companyTicker.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        companyTicker.leadingAnchor.constraint(equalTo: companyLogo.trailingAnchor, constant: 10).isActive = true
        companyTicker.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
        //companyTicker.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -200).isActive = true
    }
    
    func positionFavoriteStock() {
        contentView.addSubview(favoriteStock)
        favoriteStock.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        favoriteStock.leadingAnchor.constraint(equalTo: companyTicker.trailingAnchor, constant: 5).isActive = true
        favoriteStock.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
        //companyTicker.trailingAnchor.constraint(greaterThanOrEqualTo: contentView.trailingAnchor, constant: -200).isActive = true
    }
    
    func positionCompanyName() {
        contentView.addSubview(companyName)
        companyName.topAnchor.constraint(equalTo: companyTicker.bottomAnchor, constant: 5).isActive = true
        companyName.heightAnchor.constraint(lessThanOrEqualTo: companyTicker.heightAnchor, multiplier: 0.7).isActive = true
        companyName.leadingAnchor.constraint(equalTo: companyLogo.trailingAnchor, constant: 10).isActive = true
        companyName.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -110).isActive = true
    }
    
    func positionCompanyPrice() {
        contentView.addSubview(companyPrice)
        companyPrice.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10).isActive = true
        companyPrice.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.35).isActive = true
        companyPrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
    
    func positionCompanyChangePrice() {
        contentView.addSubview(companyChangePrice)
        companyChangePrice.topAnchor.constraint(equalTo: companyPrice.bottomAnchor, constant: 5).isActive = true
        companyChangePrice.heightAnchor.constraint(lessThanOrEqualTo: companyPrice.heightAnchor, multiplier: 0.7).isActive = true
        companyChangePrice.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10).isActive = true
    }
}
