//
//  ScheduleViewCell.swift
//
//
//  Created by Bakar Kharabadze on 7/4/24.
//

import UIKit

import UIKit

class ScheduleViewCell: UITableViewCell {
    
    private let containerView = UIView()
    private let mainStackView = UIStackView()
    private let textStackView = UIStackView()
    private let roundLabel = UILabel()
    private let titleLabel = UILabel()
    private let dateLabel = UILabel()
    private let flagImageView = UIImageView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.backgroundColor = UIColor(named: "CustomBackground")
        
        setupContainerView()
        setupMainStackView()
        setupTextStackView()
        setupRoundLabel()
        setupTitleLabel()
        setupDateLabel()
        setupFlagImageView()
    }
    
    private func setupContainerView() {
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
    
    private func setupTextStackView() {
        textStackView.axis = .vertical
        textStackView.alignment = .leading
        textStackView.spacing = 4
        mainStackView.addArrangedSubview(textStackView)
    }
    
    private func setupRoundLabel() {
        roundLabel.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        textStackView.addArrangedSubview(roundLabel)
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .bold)
        titleLabel.textColor = .white
        textStackView.addArrangedSubview(titleLabel)
    }
    
    private func setupDateLabel() {
        dateLabel.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        dateLabel.textColor = UIColor.lightGray
        textStackView.addArrangedSubview(dateLabel)
    }
    
    private func setupFlagImageView() {
        flagImageView.contentMode = .scaleAspectFit
        flagImageView.layer.cornerRadius = 4
        flagImageView.clipsToBounds = true
        
        mainStackView.addArrangedSubview(flagImageView)
        
        NSLayoutConstraint.activate([
            flagImageView.widthAnchor.constraint(equalToConstant: 60),
            flagImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
    
    func configure(round: String, title: String, date: String, flagImage: String, isUpcoming: Bool) {
        roundLabel.text = "Round \(round)"
        titleLabel.text = title
        dateLabel.text = date
        flagImageView.image = UIImage(named: flagImage, in: .module, with: nil)
        
        roundLabel.textColor = isUpcoming ? .green : .red
    }
}
