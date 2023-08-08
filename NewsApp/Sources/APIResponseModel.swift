//
//  APIResponseModel.swift
//  NewsApp
//
//  Created by Алексей Лосев on 08.08.2023.
//

import Foundation

struct APIResponseModel: Codable {
    let status: String
    let totalResults: Int
    let articles: [Article]
}

struct Article: Codable {
    let source: Source
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    let publishedAt: String
    let content: String?
}

struct Source: Codable {
    let name: String
}
