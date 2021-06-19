//
//  InfoViewController.swift
//  StockScreener
//
//  Created by Max Nechaev on 18.06.2021.
//

import UIKit

class InfoViewController: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationControllerInfo()
        
        positionBackInfoLabel()
        positionCompanyTicker()

    }
    
    //MARK: - Настройка Navigation и Search
    
    func setupNavigationControllerInfo() {
        title = "Information"
        view.backgroundColor = .systemGroupedBackground
        //navigationController?.navigationBar.prefersLargeTitles = true
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
    
    //MARK: - Размещение интерфейса
    
    func positionBackInfoLabel() {
        view.addSubview(backInfoLabel)
        backInfoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backInfoLabel.heightAnchor.constraint(equalTo: backInfoLabel.widthAnchor, multiplier: 0.25).isActive = true
    }
    func positionCompanyTicker(){
        backInfoLabel.addSubview(companyTicker)
        companyTicker.topAnchor.constraint(equalTo: backInfoLabel.topAnchor, constant: 15).isActive = true
        companyTicker.leadingAnchor.constraint(equalTo: backInfoLabel.leadingAnchor, constant: 15).isActive = true
        companyTicker.heightAnchor.constraint(equalTo: backInfoLabel.heightAnchor, multiplier: 0.4).isActive = true
        companyTicker.widthAnchor.constraint(equalTo: backInfoLabel.heightAnchor, multiplier: 0.8).isActive = true
    }


    
}


