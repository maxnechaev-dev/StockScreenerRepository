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
    private let companyInfoView = CompanyInfoView()
    
    init(model: MostActiveElement) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: - loadView

    override func loadView() {
        view = companyInfoView
    }
    //MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationControllerInfo()
        setupTopScreener()
    }
    
    //MARK: - Настройка Navigation
    
    func setupNavigationControllerInfo() {
        title = "Information"
        view.backgroundColor = .systemGroupedBackground
        //navigationController?.navigationBar.prefersLargeTitles = true
    }

    
    //MARK: - Установка верхней панели информации по акции

    fileprivate func setupTopScreener() {
        
        companyInfoView.companyTicker.text = "\(model.symbol)"
        
        if let price = model.iexRealtimePrice {
            companyInfoView.companyPrice.text = "\(price) $"
        } else if let price = model.close { companyInfoView.companyPrice.text = "\(price) $" }
        else {companyInfoView.companyPrice.text = "nil"}
        
        companyInfoView.companyName.text = model.companyName
        
        //Сделать изменение цены красной при минусе, зеленой при плюсе
        if model.change > 0 {
            companyInfoView.companyChangePrice.textColor = .green
        } else { companyInfoView.companyChangePrice.textColor = .red }
        
        //Округление до двух знаков после запятой
        let modelChange = model.change
        var modelChangeString: String {
            return String(format: "%.2f", modelChange)
        }
        
        let modelChangePercent = model.changePercent * 100
        var modelChangePercentString: String {
            return String(format: "%.2f", modelChangePercent)
        }
        
        companyInfoView.companyChangePrice.text = "\(modelChangeString) (\(modelChangePercentString)%)"

    }

    
}


