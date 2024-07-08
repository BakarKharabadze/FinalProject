//
//  TeamsTableViewCell.swift
//  
//
//  Created by Bakar Kharabadze on 7/7/24.
//

import UIKit

class TeamsTableViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let mainStackView = UIStackView()
    private let textStackView = UIStackView()
    private let rankingLabel = UILabel()
    private let teamNameLabel = UILabel()
    private let liveryNameLabel = UILabel()
    private let pointsStackView = UIStackView()
    private let teamPointsLabel = UILabel()
    private let pointsSuffixLabel = UILabel()
    private let liveryImageView = UIImageView()
    
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
        setupTeamNameLabel()
        setupLiveryNameLabel()
        setupPointsStackView()
        setupTeamPointsLabel()
        setupPointsSuffixLabel()
        setupLiveryImageView()
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
        
        containerView.addSubview(rankingLabel)
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
    
    private func setupTeamNameLabel() {
        teamNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        teamNameLabel.textColor = .white
        
        textStackView.addArrangedSubview(teamNameLabel)
    }
    
    private func setupLiveryNameLabel() {
        liveryNameLabel.font = .systemFont(ofSize: 14, weight: .regular)
        liveryNameLabel.textColor = .lightGray
        
        textStackView.addArrangedSubview(liveryNameLabel)
    }
    
    private func setupPointsStackView() {
        pointsStackView.axis = .horizontal
        pointsStackView.alignment = .leading
        pointsStackView.spacing = 4
        
        textStackView.addArrangedSubview(pointsStackView)
    }
    
    private func setupTeamPointsLabel() {
        teamPointsLabel.font = .systemFont(ofSize: 18, weight: .bold)
        teamPointsLabel.textColor = .blue
        
        pointsStackView.addArrangedSubview(teamPointsLabel)
    }
    
    private func setupPointsSuffixLabel() {
        pointsSuffixLabel.font = .systemFont(ofSize: 14, weight: .bold)
        pointsSuffixLabel.textColor = .white
        pointsSuffixLabel.text = "PTS"
        
        pointsStackView.addArrangedSubview(pointsSuffixLabel)
    }
    
    private func setupLiveryImageView() {
        liveryImageView.translatesAutoresizingMaskIntoConstraints = false
        liveryImageView.contentMode = .scaleAspectFill
        liveryImageView.layer.cornerRadius = 8
        liveryImageView.clipsToBounds = true
        
        mainStackView.addArrangedSubview(liveryImageView)
        
        NSLayoutConstraint.activate([
            liveryImageView.widthAnchor.constraint(equalToConstant: 80),
            liveryImageView.heightAnchor.constraint(equalToConstant: 80)
        ])
    }
    
    
    func configure(with team: Driver) {
        rankingLabel.text = team.ranking
        teamNameLabel.text = team.name
        liveryNameLabel.text = team.team
        teamPointsLabel.text = "\(team.points)"
        liveryImageView.image = UIImage(named: team.imageName)
    }
}
