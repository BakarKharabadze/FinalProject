//
//  DriversTableViewCell.swift
//
//
//  Created by Bakar Kharabadze on 7/5/24.
//

import UIKit
import Domain

final class DriversTableViewCell: UITableViewCell {
    
    // MARK: - Properties
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
    
    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        contentView.backgroundColor = UIColor(named: "CustomBackground")
        
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        containerView.backgroundColor = UIColor(named: "CustomCellBackground")
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
        
        mainStackView.addArrangedSubview(rankingLabel)
        rankingLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTextStackView() {
        textStackView.axis = .vertical
        textStackView.alignment = .leading
        textStackView.spacing = 4
        
        mainStackView.addArrangedSubview(textStackView)
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
        pointsStackView.axis = .horizontal
        pointsStackView.alignment = .leading
        pointsStackView.spacing = 4
        
        textStackView.addArrangedSubview(pointsStackView)
    }
    
    private func setupPointsLabel() {
        pointsLabel.font = .systemFont(ofSize: 18, weight: .bold)
        pointsLabel.textColor = .orange
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
            driverImageView.heightAnchor.constraint(equalToConstant: 100)
        ])
    }
    
    // MARK: - Configuration
    func configure(with driver: DriverEntity, viewModel: DriversViewModel) {
        rankingLabel.text = driver.position
        nameLabel.text = driver.givenName + " " + driver.familyName
        teamLabel.text = driver.constructorName
        pointsLabel.text = "\(driver.points)"
        driverImageView.image = UIImage(named: driver.driverImage, in: .module, with: nil)
    }
}
