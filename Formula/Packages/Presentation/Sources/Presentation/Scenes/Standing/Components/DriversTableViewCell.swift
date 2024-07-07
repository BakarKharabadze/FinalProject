//
//  DriversTableViewCell.swift
//
//
//  Created by Bakar Kharabadze on 7/5/24.
//

import UIKit

class DriversTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let mainStackView = UIStackView()
    private let textStackView = UIStackView()
    private let rankingLabel = UILabel()
    private let nameLabel = UILabel()
    private let teamLabel = UILabel()
    private let pointsStackView = UIStackView()
    private let pointsLabel = UILabel()
    private let pointsSuffixLabel = UILabel()
    private let driverImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(white: 0.15, alpha: 1.0)
        containerView.layer.cornerRadius = 10
        
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        
        setupMainStackView()
        setupRankingLabel()
        setupTextStackView()
        setupNameLabel()
        setupTeamLabel()
        setupPointsStackView()
        setupPointsLabel()
        setupPointsSuffixLabel()
        setupDriverImageView()
    }
    
    private func setupMainStackView() {
        containerView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .horizontal
        mainStackView.alignment = .center
        mainStackView.spacing = 12
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 12),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12),
            mainStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -12)
        ])
    }
    
    private func setupRankingLabel() {
        rankingLabel.font = .systemFont(ofSize: 18, weight: .bold)
        rankingLabel.textColor = .white
        
        mainStackView.addSubview(rankingLabel)
        rankingLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rankingLabel.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 5),
            rankingLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 5)
        ])
    }
    
    private func setupTextStackView() {
        textStackView.axis = .vertical
        textStackView.alignment = .leading
        textStackView.spacing = 4
        
        mainStackView.addArrangedSubview(textStackView)
        
        NSLayoutConstraint.activate([
            textStackView.topAnchor.constraint(equalTo: mainStackView.topAnchor, constant: 5),
            textStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 40)
        ])
    }
    
    private func setupNameLabel() {
        nameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        nameLabel.textColor = .white
        
        textStackView.addArrangedSubview(nameLabel)
    }
    
    private func setupTeamLabel() {
        teamLabel.font = .systemFont(ofSize: 14, weight: .regular)
        teamLabel.textColor = .lightGray
        
        textStackView.addArrangedSubview(teamLabel)
    }
    
    private func setupPointsStackView() {
        pointsStackView.axis = .vertical
        pointsStackView.alignment = .leading
        pointsStackView.spacing = 4
        
        textStackView.addArrangedSubview(pointsStackView)
    }
    
    private func setupPointsLabel() {
        pointsLabel.font = .systemFont(ofSize: 18, weight: .bold)
        pointsLabel.textColor = .blue
        
        pointsStackView.addArrangedSubview(pointsLabel)
    }
    
    private func setupPointsSuffixLabel() {
        pointsSuffixLabel.font = .systemFont(ofSize: 14, weight: .bold)
        pointsSuffixLabel.textColor = .white
        pointsSuffixLabel.text = "PTS"
        
        pointsStackView.addArrangedSubview(pointsSuffixLabel)
    }
    
    private func setupDriverImageView() {
        mainStackView.addArrangedSubview(driverImageView)
        driverImageView.translatesAutoresizingMaskIntoConstraints = false
        driverImageView.contentMode = .scaleAspectFill
        driverImageView.layer.cornerRadius = 8
        driverImageView.clipsToBounds = true
        
        NSLayoutConstraint.activate([
            driverImageView.widthAnchor.constraint(equalToConstant: 80),
            driverImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    func configure(with driver: Driver) {
        rankingLabel.text = driver.ranking
        nameLabel.text = driver.name
        teamLabel.text = driver.team
        pointsLabel.text = "\(driver.points)"
        driverImageView.image = UIImage(named: driver.imageName)
    }
}
