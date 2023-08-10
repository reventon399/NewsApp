//
//  UserDefaultsService.swift
//  NewsApp
//
//  Created by Алексей Лосев on 09.08.2023.
//

import Foundation

struct UserDefaultsManager {
    
    private static let cellsDefaults = UserDefaults.standard
    private static let key = "News"
    private static let decoder = JSONDecoder()
    private static let encoder = JSONEncoder()
    private init() {}
    
    static func getNewsDefaults() -> [NewsCellModel]? {
        var model: [NewsCellModel]?
        if let data = cellsDefaults.value(forKey: key) as? Data {
            model = try? decoder.decode([NewsCellModel].self, from: data)
        }
        return model
    }
    
    static func saveNews(with cellModels: [NewsCellModel]) {
        let data = try? encoder.encode(cellModels)
        cellsDefaults.set(data, forKey: key)
    }
}
