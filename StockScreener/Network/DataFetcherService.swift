//
//  DataFetcherService.swift
//  StockScreener
//
//  Created by Max Nechaev on 19.06.2021.
//

import Foundation

//MARK: - Класс для общей работы с запросами из сети

class DataFetcherService {
    
    var networkDataFetcher: DataFetcher
    
    init(networkDataFetcher: DataFetcher = NetworkDataFetcher()) {
        self.networkDataFetcher = networkDataFetcher
    }
    
    func fetchStocks (completion: @escaping (MostActive?) -> Void) {
        let url = ApiData.trendUrl
        networkDataFetcher.fetchGenericJSONData(urlString: url, response: completion)
    }
    
    func fetchStocksLogo (urlString: String, completion: @escaping (CompanyLogo?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(urlString: urlString, response: completion)
    }
    
    func fetchStockBySymbol (urlString: String, completion: @escaping (MostActiveElement?) -> Void) {
        networkDataFetcher.fetchGenericJSONData(urlString: urlString, response: completion)
    }
}
