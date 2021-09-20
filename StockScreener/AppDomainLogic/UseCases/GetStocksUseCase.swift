//
//  GetStocksUseCase.swift
//  StockScreener
//
//  Created by Max Nechaev on 24.08.2021.
//

import Foundation

protocol GetStocksUseCaseProtocol {
	func getStocks(completion: @escaping (MostActive?) -> Void)
}

final class GetStocksUseCase: GetStocksUseCaseProtocol {

	private let dataFetcher: DataFetcherServiceProtocol

	init(dataFetcher: DataFetcherServiceProtocol) {
		self.dataFetcher = dataFetcher
	}

	func getStocks(completion: @escaping (MostActive?) -> Void) {
		dataFetcher.fetchStocks(completion: completion)
	}
}
