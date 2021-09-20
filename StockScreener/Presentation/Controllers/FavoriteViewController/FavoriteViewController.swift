//
//  FavoriteViewController.swift
//  StockScreener
//
//  Created by Max Nechaev on 15.08.2021.
//

import UIKit

final class FavoriteViewController: UIViewController {
	private let favoriteSymbolsUseCase: GetFavoriteSymbolsUseCaseProtocol
	private let mostActiveElementsUseCase: MostActiveElementsUseCaseProtocol
	private let hasSymbolWithNameUseCase: HasStockWithNameUseCaseProtocol
	private let deleteStockUseCase: DeleteFavoriteStockUseCaseProtocol
	private let addStockUseCase: AddFavoriteStockUseCaseProtocol
	private let getLogoUseCase: GetLogoUseCaseProtocol
	private var mostActiveElement: MostActiveElement? = nil
	private var mostActive: MostActive = []
	private lazy var favoriteView = FavoriteView()

	init(favoriteSymbolsUseCase: GetFavoriteSymbolsUseCaseProtocol,
		 mostActiveElementsUseCase: MostActiveElementsUseCaseProtocol,
		 hasSymbolWithNameUseCase: HasStockWithNameUseCaseProtocol,
		 addStockUseCase: AddFavoriteStockUseCaseProtocol,
		 deleteStockUseCase: DeleteFavoriteStockUseCaseProtocol,
		 getLogoUseCase: GetLogoUseCaseProtocol) {
		self.favoriteSymbolsUseCase = favoriteSymbolsUseCase
		self.mostActiveElementsUseCase = mostActiveElementsUseCase
		self.hasSymbolWithNameUseCase = hasSymbolWithNameUseCase
		self.addStockUseCase = addStockUseCase
		self.deleteStockUseCase = deleteStockUseCase
		self.getLogoUseCase = getLogoUseCase
		super.init(nibName: nil, bundle: nil)
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	override func loadView() {
		view = favoriteView
		favoriteView.collectionview.delegate = self
		favoriteView.collectionview.dataSource = self
	}

    override func viewDidLoad() {
        super.viewDidLoad()
	}

	func load() {
		let symbols = favoriteSymbolsUseCase.stocks()
		guard !symbols.isEmpty else {
			mostActive = []
			favoriteView.collectionview.reloadData()
			return
		}
		mostActiveElementsUseCase.getMostActiveElements(symbols: symbols) { [weak self] elements in
			self?.mostActive = elements
			self?.favoriteView.collectionview.reloadData()
		}
	}

	override func viewWillAppear(_ animated: Bool) {
		super.viewWillAppear(animated)
		load()
	}
}

extension FavoriteViewController: UICollectionViewDataSource {
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
		let symbol = Symbol(name: element.symbol)
		getLogoUseCase.getLogo(symbol: symbol) { result in
			if cell.companyName.text == element.companyName {
				if let data = try? result.get() {
					cell.companyLogo.image = UIImage(data: data)
				} else {
					cell.companyLogo.image = nil
				}
			}
		}
		cell.onFavoriteChane = { [weak self] isFavorite in
			if isFavorite {
				self?.addStockUseCase.add(stock: symbol)
			} else {
				self?.deleteStockUseCase.delete(stock: symbol)
			}
			self?.load()
		}
		if hasSymbolWithNameUseCase.has(symbol: symbol) {
			cell.favoriteStock.tintColor = .orange
		} else {
			cell.favoriteStock.tintColor = .lightGray
		}

		return cell
	}
}

extension FavoriteViewController: UICollectionViewDelegate {

}


//MARK: - UICollectionViewDelegateFlowLayout

extension FavoriteViewController: UICollectionViewDelegateFlowLayout {

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
