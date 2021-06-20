//
//  InfoViewController.swift
//  StockScreener
//
//  Created by Max Nechaev on 18.06.2021.
//

import UIKit

class InfoViewController: UIViewController {
    
    //MARK: - Зависимости

    private let model: MostActiveElement
    
    init(model: MostActiveElement) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    //MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationControllerInfo()
        setupTopScreener()
        
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
    
    func positionBackInfoLabel() {
        view.addSubview(backInfoLabel)
        backInfoLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor).isActive = true
        backInfoLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        backInfoLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        backInfoLabel.heightAnchor.constraint(equalTo: backInfoLabel.widthAnchor, multiplier: 0.25).isActive = true
    }
    func positionCompanyTicker(){
        backInfoLabel.addSubview(companyTicker)
        companyTicker.topAnchor.constraint(equalTo: backInfoLabel.topAnchor, constant: 10).isActive = true
        companyTicker.leadingAnchor.constraint(equalTo: backInfoLabel.leadingAnchor, constant: 15).isActive = true
        companyTicker.heightAnchor.constraint(equalTo: backInfoLabel.heightAnchor, multiplier: 0.4).isActive = true
    }
    
    func positionCompanyPrice(){
        backInfoLabel.addSubview(companyPrice)
        companyPrice.bottomAnchor.constraint(equalTo: backInfoLabel.bottomAnchor, constant: -15).isActive = true
        companyPrice.leadingAnchor.constraint(equalTo: backInfoLabel.leadingAnchor, constant: 15).isActive = true
        companyPrice.heightAnchor.constraint(equalTo: backInfoLabel.heightAnchor, multiplier: 0.25).isActive = true
    }

    func positionCompanyName(){
        backInfoLabel.addSubview(companyName)
        companyName.topAnchor.constraint(equalTo: backInfoLabel.topAnchor, constant: 10).isActive = true
        companyName.leadingAnchor.constraint(equalTo: companyTicker.trailingAnchor, constant: 15).isActive = true
        companyName.heightAnchor.constraint(equalTo: backInfoLabel.heightAnchor, multiplier: 0.45).isActive = true
        companyName.trailingAnchor.constraint(lessThanOrEqualTo: backInfoLabel.trailingAnchor, constant: -50).isActive = true
    }
    
    func positionCompanyChangePrice(){
        backInfoLabel.addSubview(companyChangePrice)
        companyChangePrice.bottomAnchor.constraint(equalTo: backInfoLabel.bottomAnchor, constant: -15).isActive = true
        companyChangePrice.leadingAnchor.constraint(equalTo: companyPrice.trailingAnchor, constant: 15).isActive = true
        companyChangePrice.heightAnchor.constraint(equalTo: backInfoLabel.heightAnchor, multiplier: 0.23).isActive = true
    }
    
    //MARK: - Установка верхней панели информации по акции

    fileprivate func setupTopScreener() {
        
        companyTicker.text = "\(model.symbol)"
        
        if model.iexRealtimePrice != nil {
            companyPrice.text = "\(model.iexRealtimePrice) $"
        } else { companyPrice.text = "\(model.close) $" }
        
        companyName.text = model.companyName
        
        //Сделать изменение цены красной при минусе, зеленой при плюсе
        if model.change > 0 {
            companyChangePrice.textColor = .green
        } else { companyChangePrice.textColor = .red }
        
        //Округление до двух знаков после запятой
        let modelChange = model.change
        var modelChangeString: String {
            return String(format: "%.2f", modelChange)
        }
        
        let modelChangePercent = model.changePercent * 100
        var modelChangePercentString: String {
            return String(format: "%.2f", modelChangePercent)
        }
        
        companyChangePrice.text = "\(modelChangeString) (\(modelChangePercentString)%)"
        
        positionBackInfoLabel()
        positionCompanyTicker()
        positionCompanyPrice()
        positionCompanyName()
        positionCompanyChangePrice()
    }

    
}


