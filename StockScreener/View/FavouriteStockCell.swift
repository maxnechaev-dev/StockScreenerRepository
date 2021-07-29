//
//  FavouriteStockCell.swift
//  StockScreener
//
//  Created by Max Nechaev on 30.06.2021.
//

import UIKit

protocol FavouriteStockCellDelegate: class {
    func userDidSelect (model: MostActiveElement)
}

class FavouriteStockCell: UICollectionViewCell {
    
    let coreDataService = CoreDataService()
    weak var delegate: FavouriteStockCellDelegate?
    
    //MARK: - Зависимости
    let dataFetcherService = DataFetcherService()
    var mostActiveElement: MostActiveElement? = nil
    var mostActive: MostActive = []
    let customCell = CustomCell()
    let mainViewController = MainViewController()
    let service = FavouriteStockCellService()
    
    var cellId = "Cell"
    var symbols = ["MRIN", "AAPL", "AMC", "GE", "AMD"]
    
    
    //MARK: - Создание collectionview
    
    lazy var collectionview: UICollectionView = {
        
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionview = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionview.translatesAutoresizingMaskIntoConstraints = false
        collectionview.dataSource = self
        collectionview.delegate = self
        collectionview.register(CustomCell.self, forCellWithReuseIdentifier: cellId)
        collectionview.backgroundColor = .secondarySystemBackground
        
        return collectionview
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionview()
    }
    //MARK: - Разметка collectionview
    
    func setupCollectionview() {
        self.addSubview(collectionview)
        collectionview.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        collectionview.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        collectionview.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor).isActive = true
        collectionview.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
    }
    
    //MARK: - Функция по запросу данных по модели
    
    func load() {
        service.loadFavouriteStocks(symbols: coreDataService.getSymbolsNamesArray()) { [weak self] elements in
            self?.mostActive = elements
            self?.collectionview.reloadData()
        }
    }

    
    //MARK: - Функция по подключению логотипов компаний
    
    func takeLogo(elementSymbol: String, imageView: UIImageView) {
        
        let symbolForLogo = elementSymbol //получаем текущий symbol
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


//MARK: - UICollectionViewDelegate

extension FavouriteStockCell: UICollectionViewDelegate {
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let models = mostActive[indexPath.row]
        let model = models
        delegate?.userDidSelect(model: model)
    }
    
}

//MARK: - UICollectionViewDataSource

extension FavouriteStockCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return mostActive.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionview.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! CustomCell
        cell.backgroundColor = .white
        cell.layer.cornerRadius = 9

        
        let element = mostActive[indexPath.row]
        cell.companyTicker.text = element.symbol
        cell.companyName.text = element.companyName
        
        if let price = element.iexRealtimePrice {
            cell.companyPrice.text = "\(price)"
        } else if let price = element.close { cell.companyPrice.text = "\(price)" }
        else if let price = element.latestPrice { cell.companyPrice.text = "\(price)" }
        else {cell.companyPrice.text = "nil"}
        guard let latestPrice = element.latestPrice else { return cell }
        if cell.companyPrice.text == "0.0" { cell.companyPrice.text = "\(latestPrice)" }
        
        //Сделать изменение цены красной при минусе, зеленой при плюсе
        if element.change > 0 {
            cell.companyChangePrice.textColor = .green
        } else { cell.companyChangePrice.textColor = .red }
        
        //Округление до двух знаков после запятой
        let elementChange = element.change
        var elementChangeString: String {
            return String(format: "%.2f", elementChange)
        }
        
        let elementChangePercent = element.changePercent * 100
        var elementChangePercentString: String {
            return String(format: "%.2f", elementChangePercent)
        }
        
        cell.companyChangePrice.text = "\(elementChangeString) (\(elementChangePercentString)%)"
        
        //Поставить логотипы компаний
        takeLogo(elementSymbol: element.symbol, imageView: cell.companyLogo)
        
        if coreDataService.containsSymbol(with: element.symbol) {
            cell.favoriteStock.tintColor = .orange
        } else {
            cell.favoriteStock.tintColor = .lightGray
        }
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FavouriteStockCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let itemsPerRow: CGFloat = 1
        let paddingWidth = 20 * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem / 5)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        UIEdgeInsets(top: 10, left: 20, bottom: 20, right: 20)
    }
}

