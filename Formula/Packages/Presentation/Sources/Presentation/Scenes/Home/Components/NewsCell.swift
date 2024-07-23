//
//  NewsTableViewCell.swift
//
//
//  Created by Bakar Kharabadze on 7/4/24.
//

import UIKit
import Domain

final class NewsCell: UITableViewCell {
    
    // MARK: - Properties
    private let mainStackView = UIStackView()
    private let newsImageView = UIImageView()
    private let titleLabel = UILabel()
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(named: "CustomBackground")
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        let customBackgroundView = UIView()
        customBackgroundView.backgroundColor = UIColor(named: "CustomCellBackground")
        customBackgroundView.layer.cornerRadius = 10
        customBackgroundView.layer.masksToBounds = true
        
        contentView.addSubview(customBackgroundView)
        customBackgroundView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            customBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            customBackgroundView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            customBackgroundView.topAnchor.constraint(equalTo: contentView.topAnchor),
            customBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
        
        customBackgroundView.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: customBackgroundView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: customBackgroundView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: customBackgroundView.topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: customBackgroundView.bottomAnchor)
        ])
        
        setupNewsImage()
        setupTitleLabel()
    }
    
    private func setupNewsImage() {
        newsImageView.contentMode = .scaleAspectFill
        newsImageView.layer.cornerRadius = 10
        newsImageView.clipsToBounds = true
        
        mainStackView.addArrangedSubview(newsImageView)
        
        NSLayoutConstraint.activate([
            newsImageView.widthAnchor.constraint(equalToConstant: 350),
            newsImageView.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        
        mainStackView.addArrangedSubview(titleLabel)
    }
    
    // MARK: - Configuration
    func configure(with newsEntity: NewsEntity) {
        titleLabel.text = newsEntity.title
        
        if let urlString = newsEntity.urlToImage, let url = URL(string: urlString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.newsImageView.image = image
                    }
                }
            }
        } else {
            newsImageView.image = nil
        }
    }
}
