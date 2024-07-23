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
        mainStackView.backgroundColor = UIColor(named: "CustomCellBackground")
        mainStackView.layer.cornerRadius = 10
        mainStackView.layer.masksToBounds = true
        setupMainStackView()
        setupNewsImage()
        setupTitleLabel()
    }
    
    private func setupMainStackView() {
        contentView.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
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
