//
//  HasStockWithNameUseCase.swift
//  StockScreener
//
//  Created by Max Nechaev on 15.08.2021.
//

import Foundation

protocol HasStockWithNameUseCaseProtocol {
	func has(symbol: Symbol) -> Bool
}

class HasStockWithNameUseCase: HasStockWithNameUseCaseProtocol {

	private let repository: StocksRepositoryProtocol

	init(repository: StocksRepositoryProtocol) {
		self.repository = repository
	}

	convenience init() {
		let repository = StocksRepository(service: CoreDataService())
		self.init(repository: repository)
	}

	func has(symbol: Symbol) -> Bool {
		return repository.contains(symbol: symbol)
	}
}
