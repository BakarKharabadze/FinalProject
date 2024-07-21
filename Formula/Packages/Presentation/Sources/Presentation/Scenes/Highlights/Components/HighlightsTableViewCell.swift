//
//  HighlightsTableViewCell.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import UIKit
import Domain

final class HighlightsTableViewCell: UITableViewCell {
    
    // MARK: - Properties
    private let mainStackView = UIStackView()
    private let highlightImageView = UIImageView()
    private let highlightOverlayView = UIView()
    private let playIconImageView = UIImageView()
    private let titleLabel = UILabel()
    private let channelStackView = UIStackView()
    private let channelImageView = UIImageView()
    private let channelInfoStackView = UIStackView()
    private let channelNameLabel = UILabel()
    private let subscribersLabel = UILabel()
    
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
        backgroundColor = UIColor(named: "CustomBackground")
        let selectedBackgroundView = UIView()
        selectedBackgroundView.backgroundColor = UIColor(named: "CustomBackground")
        self.selectedBackgroundView = selectedBackgroundView

        mainStackView.backgroundColor = UIColor(named: "CustomCellBackground")
        mainStackView.layer.masksToBounds = true
        
        setupMainStackView()
        setupHighlightImage()
        setupHighlightOverlayView()
        setupPlayIconImageView()
        setupTitleLabel()
        setupChannelStackView()
    }
    
    private func setupMainStackView() {
        contentView.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .fill
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    private func setupHighlightImage() {
        highlightImageView.contentMode = .scaleAspectFill
        highlightImageView.clipsToBounds = true
        
        mainStackView.addArrangedSubview(highlightImageView)
        
        highlightImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highlightImageView.heightAnchor.constraint(equalToConstant: 200),
            highlightImageView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            highlightImageView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
    }
    
    private func setupHighlightOverlayView() {
        highlightOverlayView.backgroundColor = UIColor.black.withAlphaComponent(0.3)
        highlightOverlayView.translatesAutoresizingMaskIntoConstraints = false
        highlightImageView.addSubview(highlightOverlayView)
        
        NSLayoutConstraint.activate([
            highlightOverlayView.topAnchor.constraint(equalTo: highlightImageView.topAnchor),
            highlightOverlayView.bottomAnchor.constraint(equalTo: highlightImageView.bottomAnchor),
            highlightOverlayView.leadingAnchor.constraint(equalTo: highlightImageView.leadingAnchor),
            highlightOverlayView.trailingAnchor.constraint(equalTo: highlightImageView.trailingAnchor)
        ])
    }
    
    private func setupPlayIconImageView() {
        playIconImageView.image = UIImage(systemName: "play.circle.fill")
        playIconImageView.tintColor = .red
        playIconImageView.contentMode = .scaleAspectFit
        playIconImageView.translatesAutoresizingMaskIntoConstraints = false
        
        highlightImageView.addSubview(playIconImageView)
        
        NSLayoutConstraint.activate([
            playIconImageView.centerXAnchor.constraint(equalTo: highlightImageView.centerXAnchor),
            playIconImageView.centerYAnchor.constraint(equalTo: highlightImageView.centerYAnchor),
            playIconImageView.widthAnchor.constraint(equalToConstant: 50),
            playIconImageView.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.font = UIFont.boldSystemFont(ofSize: 16)
        titleLabel.numberOfLines = 2
        titleLabel.textColor = .white
        
        mainStackView.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -10)
        ])
    }
    
    private func setupChannelStackView() {
        mainStackView.addArrangedSubview(channelStackView)
        
        channelStackView.axis = .horizontal
        channelStackView.alignment = .center
        channelStackView.spacing = 10
        
        setupChannelImageView()
        setupChannelInfoStackView()
        
        NSLayoutConstraint.activate([
            channelStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: 10),
            channelStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: -10),
        ])
    }
    
    private func setupChannelImageView() {
        channelImageView.image = UIImage(named: "FormulaLogo")
        channelImageView.contentMode = .scaleAspectFill
        channelImageView.layer.cornerRadius = 20
        channelImageView.clipsToBounds = true
        
        channelImageView.translatesAutoresizingMaskIntoConstraints = false
        channelStackView.addArrangedSubview(channelImageView)
        
        NSLayoutConstraint.activate([
            channelImageView.widthAnchor.constraint(equalToConstant: 40),
            channelImageView.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func setupChannelInfoStackView() {
        channelInfoStackView.axis = .vertical
        channelInfoStackView.alignment = .leading
        
        channelStackView.addArrangedSubview(channelInfoStackView)
        
        setupChannelNameLabel()
        setupSubscribersLabel()
    }
    
    private func setupChannelNameLabel() {
        channelNameLabel.font = UIFont.systemFont(ofSize: 16, weight: .bold)
        channelNameLabel.textColor = .white
        channelNameLabel.text = "FORMULA 1"
        
        channelInfoStackView.addArrangedSubview(channelNameLabel)
    }
    
    private func setupSubscribersLabel() {
        subscribersLabel.font = UIFont.systemFont(ofSize: 14)
        subscribersLabel.textColor = .lightGray
        subscribersLabel.text = "10.8M subscribers"
        
        channelInfoStackView.addArrangedSubview(subscribersLabel)
    }
    
    // MARK: - Configuration
    func configure(with highlight: VideosEntity) {
        titleLabel.text = highlight.fetchedVideosTitle
        
        if let url = URL(string: highlight.fetchedVideosImgUrl) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: url), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.highlightImageView.image = image
                    }
                }
            }
        } else {
            highlightImageView.image = nil
        }
    }
}
