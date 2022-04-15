//
//  NetworkManager.swift
//  RickAndMorty
//
//  Created by Ilya on 14.04.2022.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchData(from urlString: String, with completionHandler: @escaping (Character) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, _, error in
            
            if let error = error {
                print(error.localizedDescription)
                return
            }
            
            guard let data = data else { return }
            
            do {
                let character = try JSONDecoder().decode(Character.self, from: data)
                DispatchQueue.main.async {
                    completionHandler(character)
                }
            } catch let jsonError {
                print(jsonError.localizedDescription)
            }
        }.resume()
    }
    
}

class ImageManager {
    
    static let shared = ImageManager()
    
    private init() {}
    
    func fetchImage(from url: String?) -> Data? {
        guard let stringURL = url else { return nil }
        guard let imageURL = URL(string: stringURL) else { return nil }

        return try? Data(contentsOf: imageURL)
    }
    
//    func fetchImage(from url: String?, with completionHandler: @escaping (Data?) -> Void) {
//        guard let stringURL = url else { return }
//        guard let imageURL = URL(string: stringURL) else { return }
//        
//        do {
//            let imageData = try Data(contentsOf: imageURL)
//            DispatchQueue.main.async {
//                completionHandler(imageData)
//            }
//        } catch let imageError {
//            print(imageError.localizedDescription)
//        }
//    }
}
