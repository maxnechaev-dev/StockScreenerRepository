//
//  DeleteFavoriteStockUseCase.swift
//  StockScreener
//
//  Created by Max Nechaev on 09.09.2021.
//

import UIKit

protocol DeleteFavoriteStockUseCaseProtocol {
	func delete(stock: Symbol)
}

final class DeleteFavoriteStockUseCase: DeleteFavoriteStockUseCaseProtocol {
	private let repository: StocksRepositoryProtocol

	init(repository: StocksRepositoryProtocol) {
		self.repository = repository
	}

	func delete(stock: Symbol) {
		return repository.delete(symbol: stock)
	}
}
