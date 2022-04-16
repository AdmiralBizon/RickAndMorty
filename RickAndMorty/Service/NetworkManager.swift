//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Ilya on 14.04.2022.
//

import Foundation

enum CustomError: Error {
    case invalidURL
    case invalidData
}

final class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData<T:Codable>(
        pagination: Bool = false,
        urlString: String,
        expecting: T.Type,
        completionHandler: @escaping (Swift.Result<T, Error>) -> Void) {
            
        guard let url = URL(string: urlString) else {
            completionHandler(.failure(CustomError.invalidURL))
            return
        }

        URLSession.shared.dataTask(with: url) { data, _, error in

            if let error = error {
                completionHandler(.failure(error))
                return
            }

            guard let data = data else {
                completionHandler(.failure(CustomError.invalidData))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(expecting, from: data)
                completionHandler(.success(decodedData))
            } catch {
                completionHandler(.failure(error))
            }
        }.resume()
    }

}

final class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: String?, with completionHandler: @escaping (Data) -> Void) {
        guard let stringURL = url else { return }
        guard let imageURL = URL(string: stringURL) else { return }
        
        URLSession.shared.dataTask(with: imageURL) { data, _, error in

            if let error = error {
                print(error.localizedDescription)
                return
            }

            if let imageData = data {
                completionHandler(imageData)
            }
            
        }.resume()
        
    }
    
}
