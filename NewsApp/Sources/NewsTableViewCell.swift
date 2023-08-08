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
                                                         fontWeight: .bold,
                                                         textAlignment: .center,
                                                         textColor: nil)
    
    private lazy var subtitleLabel = UILabel.configureLabel(fontSize: 15,
                                                            fontWeight: .light,
                                                            textAlignment: .natural,
                                                            textColor: nil)
    
    private lazy var numberOfClicsLabel = UILabel.configureLabel(fontSize: 10,
                                                                 fontWeight: .light,
                                                                 textAlignment: .center,
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
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Reuse
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        newsImageView.image = nil
        numberOfClicsLabel.text = nil
    }
}
