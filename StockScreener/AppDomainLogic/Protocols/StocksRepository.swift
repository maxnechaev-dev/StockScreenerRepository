//
//  StocksRepository.swift
//  StockScreener
//
//  Created by Max Nechaev on 15.08.2021.
//

import UIKit

protocol StocksRepositoryProtocol {
	func allSymbols() -> [Symbol]
	func stock(with name: String) -> Symbol?
	func save(symbol: Symbol)
	func delete(symbol: Symbol)
	func contains(symbol: Symbol) -> Bool
}

final class StocksRepository: StocksRepositoryProtocol {
	private let service: CoreDataService

	init(service: CoreDataService) {
		self.service = service
	}

	func allSymbols() -> [Symbol] {
		let symbols = service.getSymbols()
		return symbols.compactMap({ model in
			if let name = model.name {
				return Symbol(name: name)
			}
			return nil
		})
	}

	func stock(with name: String) -> Symbol? {
		return nil
	}

	func save(symbol: Symbol) {
		service.addSymbol(with: symbol.name)
	}

	func delete(symbol: Symbol) {
		service.deleteSymbol(with: symbol.name)
	}

	func contains(symbol: Symbol) -> Bool {
		service.containsSymbol(with: symbol.name)
	}
}
