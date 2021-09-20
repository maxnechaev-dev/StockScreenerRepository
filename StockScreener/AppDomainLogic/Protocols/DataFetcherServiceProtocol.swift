//
//  DataFetcherServiceProtocol.swift
//  StockScreener
//
//  Created by Max Nechaev on 17.08.2021.
//

protocol DataFetcherServiceProtocol {

	func fetchStocks (completion: @escaping (MostActive?) -> Void)

	func fetchStocksLogo (urlString: String, completion: @escaping (CompanyLogo?) -> Void)

	func fetchStockBySymbol (urlString: String, completion: @escaping (MostActiveElement?) -> Void)

	func fetchStockInfoBySymbol (urlString: String, completion: @escaping (CompanyInformation?) -> Void)
}
