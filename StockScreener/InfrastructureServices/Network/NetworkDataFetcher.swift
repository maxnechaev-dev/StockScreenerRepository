//
//  NetworkDataFetcher.swift
//  StockScreener
//
//  Created by Max Nechaev on 19.06.2021.
//

import Foundation

//MARK: - Протокол, который декодирует полученные данные

protocol DataFetcher {
    func fetchGenericJSONData <T: Codable> (urlString: String, response: @escaping (T?) -> Void)
}

class NetworkDataFetcher: DataFetcher {

    var networking: Networking
    
    init(networking: Networking = NetworkService()) {
        self.networking = networking
    }
    
    func fetchGenericJSONData <T: Codable> (urlString: String, response: @escaping (T?) -> Void) {
        
        networking.request(urlString: urlString) { (result) in
            switch result {
            
            case .success(let data):
                
                do {
                    let elements = try JSONDecoder().decode(T.self, from: data)
                    response(elements)
                    
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
