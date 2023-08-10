//
//  ViewController.swift
//  NewsApp
//
//  Created by Алексей Лосев on 08.08.2023.
//

import UIKit
import SafariServices

final class NewsViewController: UIViewController {
    
    private var viewModels = [NewsCellModel]() {
        didSet {
            UserDefaultsManager.saveNews(with: viewModels)
        }
    }

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupHierarchy()
        if let viewModelDefault = UserDefaultsManager.getNewsDefaults() {
            viewModels = viewModelDefault
            tableView.reloadData()
        } else {
            getNews()
        }
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
        
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refreshNews), for: .valueChanged)
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
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    let alertVC = UIAlertController(title: "Something went wrong!", message: "\(error.localizedDescription)", preferredStyle: .alert)
                    let action = UIAlertAction(title: "OK", style: .default)
                    alertVC.addAction(action)
                    self?.present(alertVC, animated: true)
                }
            }
        }
    }
    
    @objc
    private func refreshNews() {
        getNews()
        tableView.refreshControl?.endRefreshing()
    }
    
    // MARK: - Layout
    private func setupView() {
        title = "News"
        navigationController?.navigationBar.prefersLargeTitles = true
        view.backgroundColor = .systemBackground
    }
    private func setupHierarchy() {
        view.addSubview(tableView)
    }
}

// MARK: - TableView Extensions
extension NewsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NewsTableViewCell.identifier,
                                                       for: indexPath) as? NewsTableViewCell else {
            fatalError()
        }
        let userDefaultsCell = UserDefaultsManager.getNewsDefaults()
        cell.configure(with: userDefaultsCell![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        viewModels[indexPath.row].clicsCount += 1
        UserDefaultsManager.saveNews(with: viewModels)
        
        let userDefaultsCell = UserDefaultsManager.getNewsDefaults()
        let newsURL = userDefaultsCell![indexPath.row].url
        guard let url = URL(string: newsURL ?? "") else { return }
        let vc = SFSafariViewController(url: url)
        present(vc, animated: true, completion: nil)
        tableView.reloadRows(at: [indexPath], with: .none)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        500
    }
}
