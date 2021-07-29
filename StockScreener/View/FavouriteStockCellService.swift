//
//  FavouriteStockCellService.swift
//  StockScreener
//
//  Created by Max Nechaev on 03.07.2021.
//

import UIKit

final class FavouriteStockCellService {
    
    let dataFetcherService = DataFetcherService()
    var array: [MostActiveElement] = []
    
    func loadFavouriteStocks(symbols: [String], completion: @escaping ([MostActiveElement]) -> Void) {
        
        let dispatchGroup = DispatchGroup()
        symbols.forEach({ _ in
            dispatchGroup.enter()
        })
        
        dispatchGroup.notify(queue: .main) { [weak self] in
            guard let self = self else { return }
            completion (self.array)
        }
        for symbol in symbols {
            let urlForRequest = "https://cloud.iexapis.com/stable/stock/\(symbol)/quote?token=sk_df786d56dc4f49608540541174f42d4a"
            
            dataFetcherService.fetchStockBySymbol(urlString: urlForRequest) { [weak self] (mostActiveElement) in
                
                if let mostActiveElement = mostActiveElement {
                    self?.array.append(mostActiveElement)
                }
                dispatchGroup.leave()
                
            }
        }
    }
}
