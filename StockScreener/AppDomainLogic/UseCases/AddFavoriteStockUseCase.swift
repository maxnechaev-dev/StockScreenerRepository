//
//  AddFavoriteStockUseCase.swift
//  StockScreener
//
//  Created by Max Nechaev on 09.09.2021.
//

import UIKit

protocol AddFavoriteStockUseCaseProtocol {
	func add(stock: Symbol)
}

final class AddFavoriteStockUseCase: AddFavoriteStockUseCaseProtocol {
	private let repository: StocksRepositoryProtocol

	init(repository: StocksRepositoryProtocol) {
		self.repository = repository
	}

	func add(stock: Symbol) {
		return repository.save(symbol: stock)
	}
}
