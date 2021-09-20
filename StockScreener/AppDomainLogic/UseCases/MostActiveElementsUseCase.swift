//
//  FavouriteStockCellService.swift
//  StockScreener
//
//  Created by Max Nechaev on 03.07.2021.
//

import Foundation

protocol MostActiveElementsUseCaseProtocol {
	func getMostActiveElements(symbols: [Symbol], completion: @escaping ([MostActiveElement]) -> Void)
}

final class MostActiveElementsUseCase: MostActiveElementsUseCaseProtocol {
    
	let dataFetcherService: DataFetcherServiceProtocol

	init(dataFetcherService: DataFetcherServiceProtocol) {
		self.dataFetcherService = dataFetcherService
	}

    private var array: [MostActiveElement] = []
    
	func getMostActiveElements(symbols: [Symbol],
							   completion: @escaping ([MostActiveElement]) -> Void) {
		self.array = []
        let dispatchGroup = DispatchGroup()
        symbols.forEach({ _ in
            dispatchGroup.enter()
        })
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            completion (self.array)
        }
        for symbol in symbols {
			let urlForRequest = "https://cloud.iexapis.com/stable/stock/\(symbol.name)/quote?token=sk_df786d56dc4f49608540541174f42d4a"
            
            dataFetcherService.fetchStockBySymbol(urlString: urlForRequest) { [weak self] (mostActiveElement) in
                
                if let mostActiveElement = mostActiveElement {
                    self?.array.append(mostActiveElement)
                }
                dispatchGroup.leave()
                
            }
        }
    }
}
