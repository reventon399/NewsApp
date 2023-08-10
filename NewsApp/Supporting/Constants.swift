//
//  Constants.swift
//  NewsApp
//
//  Created by Алексей Лосев on 10.08.2023.
//

import Foundation

struct Constants {
    
    // MARK: - API
    static let API_KEY = "b5ff9d33bbd24e0199a5b687245f3d8e"
    
    static let scheme = "https"
    static let baseURL = "newsapi.org"
    static let port: Int? = nil
    static let fullURL = "https://newsapi.org/"
    
    
    static let url = URL(string: "https://newsapi.org/v2/top-headlines?country=us&pageSize=20&apiKey=b5ff9d33bbd24e0199a5b687245f3d8e")
}
