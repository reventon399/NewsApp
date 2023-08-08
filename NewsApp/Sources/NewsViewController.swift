//
//  ViewController.swift
//  NewsApp
//
//  Created by Алексей Лосев on 08.08.2023.
//

import UIKit

final class NewsViewController: UIViewController {
    
    private var viewModels = [NewsTableViewCell]() {
        didSet {
            
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        getNews()
        setupView()
        setupHierarchy()
        setupLayout()
    }
    
    override func viewDidLayoutSubviews() {
        tableView.frame = view.bounds
    }
    
    // MARK: - Outlets
    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .plain)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(NewsTableViewCell.self, forCellReuseIdentifier: NewsTableViewCell.identifier)
        return tableView
    }()
    
    private func getNews() {
        APIManager.shared.getData { [weak self] result in
            switch result {
            case .success(let article):
                self?.viewModels = article.compactMap({
                    NewsCellModel(title: $0.title,
                                  subtitle: $0.description ?? "No description",
                                  url: $0.url,
                                  imageURL: URL(string: $0.urlToImage ?? ""),
                                  clicsCount: 0)
                })
            case .failure(let error):
                
            }
        }
    }
    
    // MARK - Layout
    private func setupView() {
        title = "News"
        view.backgroundColor = .systemBackground
    }
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
    
    private func setupLayout() {
        
    }
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        500
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - UITableViewDataSource
extension NewsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier,
                                                 for: indexPath) as? NewsTableViewCell else {
                fatalError()
        }
        return cell
    }
}
