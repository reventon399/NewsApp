//
//  NewsCellModel.swift
//  NewsApp
//
//  Created by Алексей Лосев on 08.08.2023.
//

import Foundation

final class NewsCellModel: Codable {
    let title: String
    let subtitle: String
    let url: String?
    let imageURL: URL?
    var imageData: Data? = nil
    var clicsCount: Int
    
    init(title: String, subtitle: String, url: String?, imageURL: URL?, imageData: Data? = nil, clicsCount: Int) {
        self.title = title
        self.subtitle = subtitle
        self.url = url
        self.imageURL = imageURL
        self.imageData = imageData
        self.clicsCount = clicsCount
    }
}
