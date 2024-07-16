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
    
    func configure(round: String, title: String, date: String, flagImage: String) {
        roundLabel.text = round
        titleLabel.text = title
        dateLabel.text = date
        flagImageView.image = UIImage(named: flagImage, in: .module, with: nil)
        
        roundLabel.textColor = getColorForRace(title)
    }
    
    private func getColorForRace(_ raceName: String) -> UIColor {
        switch raceName {
        case "Bahrain Grand Prix":
            return UIColor(red: 0.0, green: 0.0, blue: 0.5, alpha: 1.0)  
        case "Saudi Arabian Grand Prix":
            return UIColor(red: 0.0, green: 0.5, blue: 0.0, alpha: 1.0)
        case "Australian Grand Prix":
            return UIColor(red: 0.0, green: 0.0, blue: 1.0, alpha: 1.0)
        case "Japanese Grand Prix":
            return .red
        case "Chinese Grand Prix":
            return .red
        case "Miami Grand Prix":
            return .blue
        case "Emilia Romagna Grand Prix":
            return .green
        case "Monaco Grand Prix":
            return .red
        case "Canadian Grand Prix":
            return .red
        case "Spanish Grand Prix":
            return .red
        case "Austrian Grand Prix":
            return .red
        case "British Grand Prix":
            return .blue
        case "Hungarian Grand Prix":
            return UIColor(red: 195/255, green: 33/255, blue: 72/255, alpha: 1.0)
        case "Belgian Grand Prix":
            return .black
        case "Dutch Grand Prix":
            return .orange
        case "Italian Grand Prix":
            return .green
        case "Azerbaijan Grand Prix":
            return .blue
        case "Singapore Grand Prix":
            return .red
        case "United States Grand Prix":
            return .blue
        case "Mexico City Grand Prix":
            return .green
        case "São Paulo Grand Prix":
            return .green
        case "Las Vegas Grand Prix":
            return .blue
        case "Qatar Grand Prix":
            return .red
        case "Abu Dhabi Grand Prix":
            return .black
        default:
            return .white
        }
    }
}
