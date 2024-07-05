//
//  NewsTableViewCell.swift
//
//
//  Created by Bakar Kharabadze on 7/4/24.
//

import UIKit

class NewsCell: UITableViewCell {
    
    private let mainStackView = UIStackView()
    private let newsImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        mainStackView.backgroundColor = .gray
        mainStackView.layer.cornerRadius = 10
        mainStackView.layer.masksToBounds = true
        setupMainStackView()
        setupNewsImage()
    }
    
    private func setupMainStackView() {
        contentView.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .horizontal
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
            newsImageView.widthAnchor.constraint(equalToConstant: 130),
            newsImageView.heightAnchor.constraint(equalToConstant: 130)
        ])
        
    }
    
    func configure(with imageName: String) {
            newsImageView.image = UIImage(named: imageName)
        }
}
