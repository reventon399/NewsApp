//
//  NewsTableViewCell.swift
//  NewsApp
//
//  Created by Алексей Лосев on 08.08.2023.
//

import UIKit
// НАЙТИ РАСШИРЕНИЕ ДЛЯ ИДЕНТИФАЕРОВ ЯЧЕЕК
class NewsTableViewCell: UITableViewCell {
    
    static let identifier = "NewsTableViewCell"
    
    // MARK: - Outlets
    private lazy var titleLabel = UILabel.configureLabel(fontSize: 20,
                                                         fontWeight: .semibold,
                                                         textAlignment: .center,
                                                         textColor: nil)
    
    private lazy var subtitleLabel = UILabel.configureLabel(fontSize: 15,
                                                            fontWeight: .light,
                                                            textAlignment: .left,
                                                            textColor: nil)
    
    private lazy var numberOfClicsLabel = UILabel.configureLabel(fontSize: 10,
                                                                 fontWeight: .light,
                                                                 textAlignment: .right,
                                                                 textColor: .systemGray)
    
    private lazy var newsImageView = UIImageView.configureImageView(cornerRadius: 10,
                                                                    contentMode: .scaleAspectFill,
                                                                    backgroundColor: .secondarySystemBackground)
    
        // MARK: - Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(titleLabel)
        contentView.addSubview(newsImageView)
        contentView.addSubview(subtitleLabel)
        contentView.addSubview(numberOfClicsLabel)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
        numberOfClicsLabel.text = nil
    }
    
    func configure(with viewModel: NewsCellModel) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        numberOfClicsLabel.text = "Number of clics: \(viewModel.clicsCount)"
        
        if let data = viewModel.imageData {
            newsImageView.image = UIImage(data: data)
        } else if let url = viewModel.imageURL {
            URLSession.shared.dataTask(with: url) { [weak self] data, _, error in
                guard let data = data, error == nil else { return }
                viewModel.imageData = data
                DispatchQueue.main.async {
                    self?.newsImageView.image = UIImage(data: data)
                }
            }.resume()
        }
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -5),
            
            newsImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            newsImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            newsImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            newsImageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            
            subtitleLabel.topAnchor.constraint(equalTo: newsImageView.bottomAnchor, constant: 10),
            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            subtitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            subtitleLabel.bottomAnchor.constraint(equalTo: numberOfClicsLabel.topAnchor, constant: 0),
            
            numberOfClicsLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            numberOfClicsLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            numberOfClicsLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            numberOfClicsLabel.heightAnchor.constraint(equalToConstant: 15)
        ])
    }
}
