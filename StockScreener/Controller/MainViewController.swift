//
//  ViewController.swift
//  StockScreener
//
//  Created by Max Nechaev on 08.06.2021.
//

import UIKit

class MainViewController: UIViewController {

    lazy var searchController = UISearchController()
    let networkDataFetcher = NetworkDataFetcher()
    let networkDataFetcherLogo = NetworkDataFetcherLogo()
    var mostActive: MostActive? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationController()
        setupCollectionView()

        networkDataFetcher.fetchStocks(urlString: ApiData.trendUrl) { (mostActive) in
            guard let mostActive = mostActive else { return }
            self.mostActive = mostActive
            //print("This is in viewDidLoad \(mostActive)")

            self.collectionView.reloadData()
        }
    }
    
    //MARK: - Функция по подключению логотипов компаний
    
    func takeLogo(elementSymbol: String, imageView: UIImageView) {
        
        let symbolForLogo = elementSymbol //получаем текущий symbol
        var urlLogo = "https://cloud.iexapis.com/stable/stock/\(symbolForLogo)/logo?token=sk_72487b2d2a744574a47183726ead7ba5"
        
        networkDataFetcherLogo.fetchStocksLogo(urlString: urlLogo) { (companyLogo) in
            guard let companyLogo = companyLogo else { return }
            //print("this is companyLogo \(companyLogo)")
            let url = URL(string: companyLogo.url)!
            
            if let data = try? Data(contentsOf: url) {
                imageView.image = UIImage(data: data)
            }
        }
    }
    
    //MARK: - Настройка Navigation и Search
    
    func setupNavigationController() {
        title = "Stock Screener"
        view.backgroundColor = .systemGroupedBackground
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Ticker or company name "
    }
    
    //MARK: - Настройка Collection view
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        //collectionView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        collectionView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -20).isActive = true
    }

}

