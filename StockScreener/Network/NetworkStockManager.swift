//
//  NetworkStockManager.swift
//  StockScreener
//
//  Created by Max Nechaev on 16.06.2021.
//

import Foundation
import UIKit


//MARK: - Класс, который запрашивает данные из сети

class NetworkService {
    
    enum Error: Swift.Error {
        case invalidUrl
    }
    
    func request (urlString: String, completion: @escaping (Result <Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return completion(.failure(Error.invalidUrl))
        }
        
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            DispatchQueue.main.async {
                
                if let error = error {
                    completion(.failure(error as! NetworkService.Error))
                    return
                }
                
                guard let data = data else { return }
                completion(.success(data))
                //print("Data is from URLSession \(data)")
            }
        }.resume()
    }
}

//MARK: - Класс, который парсит данные, полученные из сети

class NetworkDataFetcher {
    
    let networkService = NetworkService()
    
    func fetchStocks (urlString: String, response: @escaping (MostActive?) -> Void) {
        
        networkService.request(urlString: urlString) { (result) in
            switch result {
            
            case .success(let data):
                
                do {
                    let elements = try JSONDecoder().decode(MostActive.self, from: data)
                    response(elements)
                    //print ("Elements from Decoder is \(elements)")
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
                
            case .failure(let error):
                print("Error received requesting data:", error.localizedDescription)
                response (nil)
            }
        }
    }
}

class NetworkDataFetcherLogo {
    
    let networkService = NetworkService()
    
    func fetchStocksLogo (urlString: String, response: @escaping (CompanyLogo?) -> Void) {
        
        networkService.request(urlString: urlString) { (result) in
            switch result {
            
            case .success(let data):
                
                do {
                    let elements = try JSONDecoder().decode(CompanyLogo.self, from: data)
                    response(elements)
                    
                    //print ("Logo of company is \(elements)")
                } catch let jsonError {
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
                
            case .failure(let error):
                print("Error received requesting data:", error.localizedDescription)
                response (nil)
            }
        }
    }
}

