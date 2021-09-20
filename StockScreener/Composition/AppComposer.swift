//
//  AppComposer.swift
//  StockScreener
//
//  Created by Max Nechaev on 15.08.2021.
//

import UIKit

final class AppComposer {
	private static let coreDataService = CoreDataService()
	private static let networkDataFetcher = NetworkDataFetcher(networking: NetworkService())
	static func createMainViewController() -> UIViewController {
		weak var pageViewControllerRef: PageViewController?
		let pageViewControllerAssembly: (PageControllerOutput?) -> UIViewController = { output in
			let pageViewController = self.createPageViewController()
			pageViewController.output = output
			pageViewControllerRef = pageViewController
			return pageViewController
		}
		let mainController = MainViewController(childControllersAssembly: pageViewControllerAssembly)
		mainController.onIndexChange = { index in
			pageViewControllerRef?.setCurrentIndex(index)
		}
		return mainController
	}

	private static func createPageViewController() -> PageViewController {
		// Creatig services
		let stocksRepository = StocksRepository(service: coreDataService)
		let dataFetcher = DataFetcherService(networkDataFetcher: networkDataFetcher)

		// Creating use cases
		let favoriteSymbolsUseCase = FavoriteSymbolsUseCase(repository: stocksRepository)
		let mostActiveElementsUseCase = MostActiveElementsUseCase(dataFetcherService: dataFetcher)
		let getLogoUseCase = GetLogoUseCase(dataFetcherService: dataFetcher)
		let hasSymbolWithNameUseCase = HasStockWithNameUseCase(repository: stocksRepository)
		let addStockUseCase = AddFavoriteStockUseCase(repository: stocksRepository)
		let deleteStockUseCase = DeleteFavoriteStockUseCase(repository: stocksRepository)
		// creating controllers
		let favoriteViewController = FavoriteViewController(favoriteSymbolsUseCase: favoriteSymbolsUseCase,
															mostActiveElementsUseCase: mostActiveElementsUseCase,
															hasSymbolWithNameUseCase: hasSymbolWithNameUseCase,
															addStockUseCase: addStockUseCase,
															deleteStockUseCase: deleteStockUseCase,
															getLogoUseCase: getLogoUseCase)

		let getStocksUseCase = GetStocksUseCase(dataFetcher: dataFetcher)
		let searchController = SearchViewController(hasSymbolUseCase: hasSymbolWithNameUseCase,
													mostActiveElementsUseCase: mostActiveElementsUseCase,
													getStocksUseCase: getStocksUseCase,
													deleteStockUseCase: deleteStockUseCase,
													addStockUseCase: addStockUseCase, companyInfoViewControllerAssembly: createCompanyInfoViewControllerAssembly())
		
		let pageController = PageViewController(controllers: [searchController, favoriteViewController],
								  style: .scroll,
								  navigationOrientation: .horizontal)
		return pageController
	}

	private static func createCompanyInfoViewControllerAssembly() -> (MostActiveElement) -> UIViewController {
		return { element in
			return InfoVC(model: element)
		}
	}
}
