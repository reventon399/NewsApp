//
//  APIManager.swift
//  NewsApp
//
//  Created by Алексей Лосев on 08.08.2023.
//

import Foundation

final class APIManager {
    static let shared = APIManager()
    
    private init() {}
    
    private func getURL() {
        
    }
    
    public func getData(completion: @escaping (Result<[Article], Error>) -> Void) {
        guard let url = Constants.url else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(error))
            }
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(APIResponseModel.self, from: data)
                    completion(.success(result.articles))
                    print(result)
                } catch {
                    completion(.failure(error))
                }
                
            }
        }
        task.resume()
    }
    
}
