//
//  NetworkService.swift
//  StockScreener
//
//  Created by Max Nechaev on 19.06.2021.
//

import Foundation

//MARK: - Протокол, который запрашивает данные из сети

protocol Networking {
    func request (urlString: String, completion: @escaping (Result <Data, Error>) -> Void)
    }

class NetworkService: Networking {

    func request (urlString: String, completion: @escaping (Result <Data, Error>) -> Void) {

        guard let url = URL(string: urlString) else { return }

        let request = URLRequest(url: url)
        let task = createDataTask(from: request, completion: completion)
        task.resume()
    }
    
    
    private func createDataTask (from request: URLRequest, completion: @escaping (Result <Data, Error>) -> Void) -> URLSessionDataTask {
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                completion(.success(data))
            }
        }
    }
    
}

