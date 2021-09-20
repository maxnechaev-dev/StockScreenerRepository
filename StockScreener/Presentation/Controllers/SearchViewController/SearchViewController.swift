//
//  SearchViewController.swift
//  StockScreener
//
//  Created by Max Nechaev on 15.08.2021.
//

import UIKit

final class SearchViewController: UIViewController {

	private let hasSymbolUseCase: HasStockWithNameUseCaseProtocol
	private let mostActiveElementsUseCase: MostActiveElementsUseCaseProtocol
	private var mostActive: [MostActiveElement] = []
	private lazy var searchView = SearchView()
	private let getStocksUseCase: GetStocksUseCaseProtocol
	private let companyInfoViewControllerAssembly: (MostActiveElement) -> UIViewController
	private let deleteStockUseCase: DeleteFavoriteStockUseCaseProtocol
	private let addStockUseCase: AddFavoriteStockUseCaseProtocol

	init(hasSymbolUseCase: HasStockWithNameUseCaseProtocol,
		 mostActiveElementsUseCase: MostActiveElementsUseCaseProtocol,
		 getStocksUseCase: GetStocksUseCaseProtocol,
		 deleteStockUseCase: DeleteFavoriteStockUseCaseProtocol,
		 addStockUseCase: AddFavoriteStockUseCaseProtocol,
		 companyInfoViewControllerAssembly: @escaping (MostActiveElement) -> UIViewController) {
		self.hasSymbolUseCase = hasSymbolUseCase
		self.mostActiveElementsUseCase = mostActiveElementsUseCase
		self.getStocksUseCase = getStocksUseCase
		self.addStockUseCase = addStockUseCase
		self.deleteStockUseCase = deleteStockUseCase
		self.companyInfoViewControllerAssembly = companyInfoViewControllerAssembly
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = searchView
	}

	override func viewDidLoad() {
        super.viewDidLoad()
		searchView.collectionview.delegate = self
		searchView.collectionview.dataSource = self
    }

	func fetchData() {
		getStocksUseCase.getStocks { [weak self] (mostActive) in
			guard let self = self,
				  let mostActive = mostActive else { return }
			self.mostActive = mostActive
			self.searchView.collectionview.reloadData()
		}
	}
	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		fetchData()
	}
}

extension SearchViewController: UICollectionViewDataSource {

	func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
		return mostActive.count
	}

	func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
		let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCell.cellId, for: indexPath) as! CustomCell
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
//		takeLogo(elementSymbol: element.symbol, imageView: cell.companyLogo)

		if hasSymbolUseCase.has(symbol: .init(name: element.symbol)) {
			cell.favoriteStock.tintColor = .orange
		} else {
			cell.favoriteStock.tintColor = .lightGray
		}
		cell.onFavoriteChane = { [weak self] isFavorite in
			let symbol = Symbol(name: element.symbol)
			if isFavorite {
				self?.addStockUseCase.add(stock: symbol)
			} else {
				self?.deleteStockUseCase.delete(stock: symbol)
			}
		}

		return cell
	}
}

extension SearchViewController: UICollectionViewDelegate {


	func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
		let model = mostActive[indexPath.row]
		let infoViewController = companyInfoViewControllerAssembly(model)
		present(infoViewController, animated: true, completion: nil)
	}

}

//MARK: - UICollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {

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
