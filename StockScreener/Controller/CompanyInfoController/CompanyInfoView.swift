//
//  CompanyInfoswift
//  StockScreener
//
//  Created by Max Nechaev on 21.06.2021.
//

import UIKit

class CompanyInfoView: UIView {
    
    init() {
        super.init(frame: .zero)
        
        positionBackInfoLabel()
        positionCompanyTicker()
        positionCompanyPrice()
        positionCompanyName()
        positionCompanyChangePrice()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Создание интерфейса

    let backInfoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.backgroundColor = .darkGray
        
        return label
    }()
    
    let companyTicker: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        //label.backgroundColor = .red
        label.text = "AAPL"
        label.font = UIFont.boldSystemFont(ofSize: 30)
        label.textColor = .white
        
        return label
    }()
    
    let companyPrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "135.65"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        //label.backgroundColor = .red
        label.textColor = .white

        return label
    }()
    
    let companyName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "APPLE INC"
        label.font = UIFont.systemFont(ofSize: 18)
        //label.backgroundColor = .red
        label.textColor = .white

        return label
    }()
    
    let companyChangePrice: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "+0.13 (1.14%)"
        label.font = UIFont.systemFont(ofSize: 18)
        //label.backgroundColor = .red
        label.textColor = .white

        return label
    }()
    
    //MARK: - Размещение интерфейса
    
    private func positionBackInfoLabel() {
        addSubview(backInfoLabel)
        backInfoLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        backInfoLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        backInfoLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        backInfoLabel.heightAnchor.constraint(equalTo: backInfoLabel.widthAnchor, multiplier: 0.25).isActive = true
    }
    private func positionCompanyTicker(){
        backInfoLabel.addSubview(companyTicker)
        companyTicker.topAnchor.constraint(equalTo: backInfoLabel.topAnchor, constant: 10).isActive = true
        companyTicker.leadingAnchor.constraint(equalTo: backInfoLabel.leadingAnchor, constant: 15).isActive = true
        companyTicker.heightAnchor.constraint(equalTo: backInfoLabel.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    private func positionCompanyPrice(){
        backInfoLabel.addSubview(companyPrice)
        companyPrice.bottomAnchor.constraint(equalTo: backInfoLabel.bottomAnchor, constant: -15).isActive = true
        companyPrice.leadingAnchor.constraint(equalTo: backInfoLabel.leadingAnchor, constant: 15).isActive = true
        companyPrice.heightAnchor.constraint(equalTo: backInfoLabel.heightAnchor, multiplier: 0.25).isActive = true
    }

    private func positionCompanyName(){
        backInfoLabel.addSubview(companyName)
        companyName.topAnchor.constraint(equalTo: backInfoLabel.topAnchor, constant: 10).isActive = true
        companyName.leadingAnchor.constraint(equalTo: companyTicker.trailingAnchor, constant: 15).isActive = true
        companyName.heightAnchor.constraint(equalTo: backInfoLabel.heightAnchor, multiplier: 0.45).isActive = true
        companyName.trailingAnchor.constraint(lessThanOrEqualTo: backInfoLabel.trailingAnchor, constant: -50).isActive = true
    }
    
    private func positionCompanyChangePrice(){
        backInfoLabel.addSubview(companyChangePrice)
        companyChangePrice.bottomAnchor.constraint(equalTo: backInfoLabel.bottomAnchor, constant: -15).isActive = true
        companyChangePrice.leadingAnchor.constraint(equalTo: companyPrice.trailingAnchor, constant: 15).isActive = true
        companyChangePrice.heightAnchor.constraint(equalTo: backInfoLabel.heightAnchor, multiplier: 0.23).isActive = true
    }

}
