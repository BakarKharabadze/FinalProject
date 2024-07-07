//
//  StandingViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/3/24.
//

import UIKit

final class StandingViewController: UIViewController {
    
    private let mainStackView = UIStackView()
    private let titleLabel = UILabel()
    private let driversView = UIView()
    private let driversTitle = UILabel()
    private let driversImage = UIImageView()
    private let teamsView = UIView()
    private let teamsTitle = UILabel()
    private let teamsImage = UIImageView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        
    }
    
    private func setupUI() {
        setupMainStackView()
        setupTitleLabel()
        setupDriversView()
        setupDriversTitle()
        setupDriversImage()
        setupTeamsView()
        setupTeamsTitle()
        setupTeamsImage()
        setupGestureRecognizers()
        
        
        setupCustomSpacing()
    }
    
    private func setupMainStackView() {
        view.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .center
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 70),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupCustomSpacing() {
        mainStackView.setCustomSpacing(50, after: titleLabel)
        mainStackView.setCustomSpacing(20, after: driversView)
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Standings"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        
        mainStackView.addArrangedSubview(titleLabel)
    }
    
    private func setupDriversView() {
        driversView.backgroundColor = .gray
        driversView.layer.cornerRadius = 10
        driversView.layer.masksToBounds = true
        
        mainStackView.addArrangedSubview(driversView)
        
        NSLayoutConstraint.activate([
            driversView.widthAnchor.constraint(equalToConstant: 350),
            driversView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
    }
    
    private func setupDriversTitle() {
        driversTitle.text = "Drivers"
        driversTitle.textColor = .white
        driversTitle.font = .systemFont(ofSize: 20)
        
        driversTitle.translatesAutoresizingMaskIntoConstraints = false
        driversView.addSubview(driversTitle)
        
        NSLayoutConstraint.activate([
            driversTitle.leadingAnchor.constraint(equalTo: driversView.leadingAnchor, constant: 15),
            driversTitle.topAnchor.constraint(equalTo: driversView.topAnchor, constant: 25)
        ])
        
    }
    
    private func setupDriversImage() {
        driversImage.image = UIImage(named: "Driver")
        driversImage.contentMode = .scaleAspectFill
        
        driversImage.translatesAutoresizingMaskIntoConstraints = false
        
        driversView.addSubview(driversImage)
        
        NSLayoutConstraint.activate([
            driversImage.trailingAnchor.constraint(equalTo: driversView.trailingAnchor, constant: -30)
        ])
    }
    
    private func setupTeamsView() {
        teamsView.backgroundColor = .gray
        teamsView.layer.cornerRadius = 10
        teamsView.layer.masksToBounds = true
        
        mainStackView.addArrangedSubview(teamsView)
        
        NSLayoutConstraint.activate([
            teamsView.widthAnchor.constraint(equalToConstant: 350),
            teamsView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
    }
    
    private func setupTeamsTitle() {
        teamsTitle.text = "Teams"
        teamsTitle.textColor = .white
        teamsTitle.font = .systemFont(ofSize: 20)
        
        teamsTitle.translatesAutoresizingMaskIntoConstraints = false
        teamsView.addSubview(teamsTitle)
        
        NSLayoutConstraint.activate([
            teamsTitle.leadingAnchor.constraint(equalTo: teamsView.leadingAnchor, constant: 15),
            teamsTitle.topAnchor.constraint(equalTo: teamsView.topAnchor, constant: 25)
        ])
    }
    
    private func setupTeamsImage() {
        teamsImage.image = UIImage(named: "Livery")
        teamsImage.contentMode = .scaleAspectFill
        
        teamsImage.translatesAutoresizingMaskIntoConstraints = false
        
        teamsView.addSubview(teamsImage)
        
        NSLayoutConstraint.activate([
            teamsImage.bottomAnchor.constraint(equalTo: teamsView.bottomAnchor)
        ])
    }
    
    private func setupGestureRecognizers() {
        let driversTapGesture = UITapGestureRecognizer(target: self, action: #selector(driversViewTapped))
        driversView.addGestureRecognizer(driversTapGesture)
        
        let teamsTapGesture = UITapGestureRecognizer(target: self, action: #selector(teamsViewTapped))
        teamsView.addGestureRecognizer(teamsTapGesture)
        
    }
    
    @objc private func driversViewTapped() {
        let driversVC = DriversViewController()
        navigationController?.pushViewController(driversVC, animated: false)
    }
    
    @objc private func teamsViewTapped() {
        let teamsVC = TeamsViewController()
        navigationController?.pushViewController(teamsVC, animated: false)
    }
}

