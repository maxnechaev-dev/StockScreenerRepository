//
//  MenuCell.swift
//  StockScreener
//
//  Created by Max Nechaev on 23.06.2021.
//

import UIKit

class MenuCell: UICollectionViewCell {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupTextLabel()
    }
    
    //MARK: - Настройка анимации нажатия на вкладку
    
    override var isHighlighted: Bool {
        didSet {
            textLabel.font = isHighlighted ? .boldSystemFont(ofSize: 20) : .none
        }
    }
    
    override var isSelected: Bool {
        didSet {
            textLabel.font = isSelected ? .boldSystemFont(ofSize: 20) : .none
        }
    }
    
    //MARK: - Создание наименования вкладки
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.text = "Text"
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupTextLabel() {
        addSubview(textLabel)
        textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor).isActive = true
        textLabel.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
