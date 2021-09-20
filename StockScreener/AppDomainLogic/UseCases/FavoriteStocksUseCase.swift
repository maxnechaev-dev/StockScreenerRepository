//
//  FavoriteStocksUseCase.swift
//  StockScreener
//
//  Created by Max Nechaev on 05.08.2021.
//

import Foundation

protocol GetFavoriteSymbolsUseCaseProtocol {
	func stocks() -> [Symbol]
}

final class FavoriteSymbolsUseCase: GetFavoriteSymbolsUseCaseProtocol {

	private let repository: StocksRepositoryProtocol

	init(repository: StocksRepositoryProtocol) {
		self.repository = repository
	}

	func stocks() -> [Symbol] {
		return repository.allSymbols().sorted(by: { $0.name < $1.name })
	}
}
