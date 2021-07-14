//
//  OtherInfoCell.swift
//  StockScreener
//
//  Created by Max Nechaev on 14.07.2021.
//

import UIKit

class OtherInfoCell: UICollectionViewCell {
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
    
    let employees: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .white
        label.text = "Number of employees: 130340"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    let city: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .white
        label.text = "City: San-Francisco"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    let state: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.backgroundColor = .white
        label.text = "State: California"
        label.textAlignment = .left
        label.font = .systemFont(ofSize: 17)
        
        return label
    }()
    
    private func setupLabels() {
        addSubview(employees)
        employees.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        employees.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        employees.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(city)
        city.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        city.topAnchor.constraint(equalTo: employees.bottomAnchor, constant: 2).isActive = true
        city.heightAnchor.constraint(equalToConstant: 30).isActive = true
        
        addSubview(state)
        state.leftAnchor.constraint(equalTo: leftAnchor, constant: 10).isActive = true
        state.topAnchor.constraint(equalTo: city.bottomAnchor, constant: 2).isActive = true
        state.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
