//
//  InfoVC.swift
//  StockScreener
//
//  Created by Max Nechaev on 01.07.2021.
//

import UIKit

class InfoVC: UIViewController {
    
    init(model: MostActiveElement) {
        self.model = model
        super.init(nibName: nil, bundle: nil)
    }
    
    //MARK: - Создание collectionView
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = .systemGray6
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellId)
        collectionView.register(TitleCell.self, forCellWithReuseIdentifier: idTitle)
        collectionView.register(PriceCell.self, forCellWithReuseIdentifier: idPrice)
        collectionView.register(DescriptionCell.self, forCellWithReuseIdentifier: idDescription)
        collectionView.register(OtherInfoCell.self, forCellWithReuseIdentifier: idOtherInfo)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        return collectionView
    }()
    
    //MARK: - Зависимости
    let dataFetcherService = DataFetcherService()
    private let model: MostActiveElement
    var companyInformation: CompanyInformation? = nil
    
    let cellId = "cellId"
    let idTitle = "idTitle"
    let idPrice = "idPrice"
    let idDescription = "idDescription"
    let idOtherInfo = "idOtherInfo"


    //MARK: - viewDidLoad

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        takeCompanyInfo()
    }
    
    
    //MARK: - Функция по запросу информации о компании

    func takeCompanyInfo() {
        let currentSymbol = model.symbol
        let urlInfo = "https://cloud.iexapis.com/stable/stock/\(currentSymbol)/company?token=sk_df786d56dc4f49608540541174f42d4a"

        dataFetcherService.fetchStockInfoBySymbol(urlString: urlInfo) { companyInfo in
            guard let companyInformation = companyInfo else { return }
            self.companyInformation = companyInformation
            self.collectionView.reloadData()
        }
    }
    
    
    //MARK: - Функция по подключению логотипов компаний
    
    func takeLogo(imageView: UIImageView) {
        
        let symbolForLogo = model.symbol //получаем текущий symbol
        let urlLogo = "https://cloud.iexapis.com/stable/stock/\(symbolForLogo)/logo?token=sk_df786d56dc4f49608540541174f42d4a"
        
        dataFetcherService.fetchStocksLogo(urlString: urlLogo) { (companyLogo) in
            guard let companyLogo = companyLogo else { return }
            
            guard let url = URL(string: companyLogo.url) else { return print("\(symbolForLogo) don't have logo!")}
            
            if let data = try? Data(contentsOf: url) {
                imageView.image = UIImage(data: data)
            }
        }
    }
    

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

//MARK: - extension InfoVC

extension InfoVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if indexPath.item == 0 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idTitle, for: indexPath) as! TitleCell
            cell.mainTitle.text = model.companyName
            
            if let industry = companyInformation?.industry {
                cell.industryLabel.text = industry
            }
            
            return cell
            
        } else if indexPath.item == 1 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idPrice, for: indexPath) as! PriceCell
            cell.symbol.text = model.symbol

            
            if let price = model.iexRealtimePrice {
                cell.price.text = "\(price) $"
            } else if let price = model.close { cell.price.text = "\(price) $" }
            else if let price = model.latestPrice { cell.price.text = "\(price) $" }
            else {cell.price.text = "nil"}
            guard let latestPrice = model.latestPrice else { return cell }
            
            if cell.price.text == "0.0 $" { cell.price.text = "\(latestPrice) $" }
            
            //Сделать изменение цены красной при минусе, зеленой при плюсе
            if model.change > 0 {
                cell.price.textColor = .green
            } else { cell.price.textColor = .red }
            
            //Округление до двух знаков после запятой
            let elementChange = model.change
            var elementChangeString: String {
                return String(format: "%.2f", elementChange)
            }
            
            let elementChangePercent = model.changePercent * 100
            var elementChangePercentString: String {
                return String(format: "%.2f", elementChangePercent)
            }
            takeLogo(imageView: cell.companyLogo)
            
            return cell
            
        } else if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idDescription, for: indexPath) as! DescriptionCell
            
            if let descCompany = companyInformation?.description {
                cell.textView.text = descCompany
            }
            
            return cell
            
        } else if indexPath.item == 3 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: idOtherInfo, for: indexPath) as! OtherInfoCell
            
            if let employees = companyInformation?.employees {
                cell.employees.text = "Number of employees: \(employees)"
            }
            
            if let city = companyInformation?.city {
                cell.city.text = "City: \(city)"
            }
            
            if let state = companyInformation?.state {
                cell.state.text = "State: \(state)"
            }
            
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath)
            return cell
        }
        

    }
}

extension InfoVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width: CGFloat
        let height: CGFloat
        
        if indexPath.item == 0 {
            width = collectionView.frame.width - 40
            height = 60
        } else if indexPath.item == 1 {
            width = collectionView.frame.width - 40
            height = 100
        } else if indexPath.item == 2 {
            width = collectionView.frame.width - 40
            height = 250
        } else {
            width = collectionView.frame.width - 40
            height = 115
        }
        
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
    }
}
