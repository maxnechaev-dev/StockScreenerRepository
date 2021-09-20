//
//  GetLogoUseCase.swift
//  StockScreener
//
//  Created by Max Nechaev on 17.08.2021.
//

import Foundation

enum LogoErrors: Error {
	case noLogo
}

protocol GetLogoUseCaseProtocol {
	func getLogo(symbol: Symbol, completion: @escaping (Result<Data, LogoErrors>) -> Void)
}
class GetLogoUseCase: GetLogoUseCaseProtocol {
	let dataFetcherService: DataFetcherServiceProtocol

	init(dataFetcherService: DataFetcherServiceProtocol) {
		self.dataFetcherService = dataFetcherService
	}

	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}

	func getLogo(symbol: Symbol, completion: @escaping (Result<Data, LogoErrors>) -> Void) {

		let urlLogo = "https://cloud.iexapis.com/stable/stock/\(symbol.name)/logo?token=sk_df786d56dc4f49608540541174f42d4a"

		dataFetcherService.fetchStocksLogo(urlString: urlLogo) { (companyLogo) in
			guard let companyLogo = companyLogo,
				  let url = URL(string: companyLogo.url),
				  let data = try? Data(contentsOf: url) else {
				completion(.failure(.noLogo))
				return
			}
			completion(.success(data))
		}
	}

}
