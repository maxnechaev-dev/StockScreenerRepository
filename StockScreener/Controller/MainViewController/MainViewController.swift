//
//  ViewController.swift
//  StockScreener
//
//  Created by Max Nechaev on 08.06.2021.
//

import UIKit

class MainViewController: UIViewController {
    
    func cellWasPressed(model: MostActiveElement) {
        present(InfoViewController(model: model), animated: true, completion: nil)
        navigationController?.pushViewController(InfoViewController(model: model), animated: true)
    }
    

    lazy var searchController = UISearchController()
//    var identifier = "cellId"
//    var favouriteCellID = "favouriteCellID"

    
    //MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavigationController()
        setupMenuBar()
        setupCollectionView()
    }
    
    //MARK: - Пока не работает, поправить (пуш для класса TrendingStockCell)
    func pushViewController(infoVC: InfoViewController) {
        navigationController?.pushViewController(infoVC, animated: true)
    }
    
    //MARK: - Настройка взаимодействия с MenuBar

    //метод для изменения Trending, Favorite во время нажатия на них
    func scrollToMenuIndex (menuIndex: Int){
        let indexPath = NSIndexPath(item: menuIndex, section: 0)
        collectionView.isPagingEnabled = false
        self.collectionView.scrollToItem(at: indexPath as IndexPath, at: [], animated: true)
        collectionView.isPagingEnabled = true
    }
    //метод для изменения Trending, Favorite во время перетягивания влево вправо
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let index = targetContentOffset.pointee.x / view.frame.width
        let indexPath = NSIndexPath(item: Int(index), section: 0)
        menuBar.collectionView.selectItem(at: indexPath as IndexPath, animated: true, scrollPosition: [])
    }
    //MARK: - Создание MenuBar
    
    lazy var menuBar: MenuBar = {
        let mb = MenuBar()
        mb.translatesAutoresizingMaskIntoConstraints = false
        mb.mainViewController = self
        
        return mb
    }()
    
    
    private func setupMenuBar() {
        view.addSubview(menuBar)
        menuBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 0).isActive = true
        menuBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        menuBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        menuBar.heightAnchor.constraint(equalToConstant: 35).isActive = true
    }
    
    //MARK: - Настройка Navigation и Search
    
    func setupNavigationController() {
        title = "Stock Screener"
        view.backgroundColor = .systemGroupedBackground
        navigationItem.searchController = searchController
        searchController.searchBar.placeholder = "Ticker or company name "
        navigationController?.navigationBar.prefersLargeTitles = true

    }
    
    //MARK: - Настройка Collection view
    
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.isPagingEnabled = true
        
        collectionView.register(TrendingStockCell.self, forCellWithReuseIdentifier: "trendingCellID")
        collectionView.register(FavouriteStockCell.self, forCellWithReuseIdentifier: "favouriteCellID")


        return collectionView
    }()
    
    func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.topAnchor.constraint(equalTo: menuBar.bottomAnchor, constant: 0).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: 50).isActive = true
    }
}

