//
//  RaceDetailViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/14/24.
//

import UIKit
import SwiftUI

// MARK: - RaceDetailViewController
final public class RaceDetailViewController: UIViewController {
    
    // MARK: - Properties
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let mainStackView = UIStackView()
    private let countryNameLabel = UILabel()
    private let grandPrixNameLabel = UILabel()
    private let dateLabel = UILabel()
    private let circuitLenghtLabel = UILabel()
    private let distanceLabel = UILabel()
    private let lapsLabel = UILabel()
    private let lapsQuantity = UILabel()
    private let turnsLabel = UILabel()
    private let turnsQuantity = UILabel()
    private let topSpeedLabel = UILabel()
    private let topSpeed = UILabel()
    private let raceWeekendContainer = UIView()
    private let circuitMapImageView = UIImageView()
    private let horizontalStackView = UIStackView()
    private let infoStackView = UIStackView()
    
    private var viewModel: RaceDetailViewModel!
    
    // MARK: - Initialization
    public class func create(with viewModel: RaceDetailViewModel) -> RaceDetailViewController {
        let vc = RaceDetailViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CustomBackground")
        navigationController?.navigationBar.barTintColor = UIColor(named: "CustomBackground")
        navigationController?.setNavigationBarHidden(false, animated: false)
        setupUI()
        viewModel.viewDidLoad()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        setupScrollView()
        setupContentView()
        setupMainStackView()
        setupCountryNameLabel()
        setupGrandPrixNameLabel()
        setupDateLabel()
        setupCircuitLenghtLabel()
        setupDistanceLabel()
        setupCircuitMapImageView()
        setupRaceWeekendContainer()
        setupCustomSpacing()
    }
    
    private func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupContentView() {
        scrollView.addSubview(contentView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        contentView.backgroundColor = UIColor(named: "CustomBackground")
        NSLayoutConstraint.activate([
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
    }
    
    private func setupMainStackView() {
        contentView.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .leading
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupCustomSpacing() {
        mainStackView.setCustomSpacing(70, after: dateLabel)
        mainStackView.setCustomSpacing(3, after: circuitLenghtLabel)
        mainStackView.setCustomSpacing(25, after: distanceLabel)
        mainStackView.setCustomSpacing(25, after: horizontalStackView)
    }
    
    private func setupCountryNameLabel() {
        countryNameLabel.text = "Australia"
        countryNameLabel.textColor = .white
        countryNameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        
        mainStackView.addArrangedSubview(countryNameLabel)
    }
    
    private func setupGrandPrixNameLabel() {
        grandPrixNameLabel.text = "Australia Grand Prix"
        grandPrixNameLabel.font = .systemFont(ofSize: 20)
        grandPrixNameLabel.textColor = .yellow
        
        mainStackView.addArrangedSubview(grandPrixNameLabel)
    }
    
    private func setupDateLabel() {
        dateLabel.text = "23-24 March"
        dateLabel.font = .systemFont(ofSize: 16)
        dateLabel.textColor = .lightGray
        
        mainStackView.addArrangedSubview(dateLabel)
    }
    
    private func setupCircuitLenghtLabel() {
        circuitLenghtLabel.text = "Circuit lenght"
        circuitLenghtLabel.font = .systemFont(ofSize: 16)
        circuitLenghtLabel.textColor = .gray
        
        mainStackView.addArrangedSubview(circuitLenghtLabel)
    }
    
    private func setupDistanceLabel() {
        distanceLabel.text = "5.303 km"
        distanceLabel.font = .systemFont(ofSize: 30, weight: .bold)
        distanceLabel.textColor = .white
        
        mainStackView.addArrangedSubview(distanceLabel)
    }
    
    private func setupCircuitMapImageView() {
        circuitMapImageView.contentMode = .scaleAspectFit
        circuitMapImageView.image = UIImage(systemName: "heart.fill")
        circuitMapImageView.tintColor = .systemBlue
        
        infoStackView.axis = .vertical
        infoStackView.alignment = .leading
        infoStackView.spacing = 10
        
        horizontalStackView.axis = .horizontal
        horizontalStackView.alignment = .top
        horizontalStackView.distribution = .equalSpacing
        horizontalStackView.spacing = 20
        
        [setupLapsLabel, setupLapsQuantity, setupTurnsLabel, setupTurnsQuantity, setupTopSpeedLabel, setupTopSpeed].forEach { method in
            method()
            if let lastView = infoStackView.arrangedSubviews.last {
                infoStackView.setCustomSpacing(3, after: lastView)
            }
        }
        
        horizontalStackView.addArrangedSubview(infoStackView)
        horizontalStackView.addArrangedSubview(circuitMapImageView)
        
        mainStackView.addArrangedSubview(horizontalStackView)
        
        NSLayoutConstraint.activate([
            circuitMapImageView.widthAnchor.constraint(equalToConstant: 200),
            circuitMapImageView.heightAnchor.constraint(equalToConstant: 200),
            horizontalStackView.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor),
            horizontalStackView.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor)
        ])
    }
    
    private func setupLapsLabel() {
        lapsLabel.text = "N. of laps"
        lapsLabel.font = .systemFont(ofSize: 16)
        lapsLabel.textColor = .gray
        
        infoStackView.addArrangedSubview(lapsLabel)
    }
    
    private func setupLapsQuantity() {
        lapsQuantity.text = "58"
        lapsQuantity.font = .systemFont(ofSize: 30, weight: .bold)
        lapsQuantity.textColor = .white
        
        infoStackView.addArrangedSubview(lapsQuantity)
    }
    
    private func setupTurnsLabel() {
        turnsLabel.text = "Turns"
        turnsLabel.font = .systemFont(ofSize: 16)
        turnsLabel.textColor = .gray
        
        infoStackView.addArrangedSubview(turnsLabel)
    }
    
    private func setupTurnsQuantity() {
        turnsQuantity.text = "14"
        turnsQuantity.font = .systemFont(ofSize: 30, weight: .bold)
        turnsQuantity.textColor = .white
        
        infoStackView.addArrangedSubview(turnsQuantity)
    }
    
    private func setupTopSpeedLabel() {
        topSpeedLabel.text = "Top speed"
        topSpeedLabel.font = .systemFont(ofSize: 16)
        topSpeedLabel.textColor = .gray
        
        infoStackView.addArrangedSubview(topSpeedLabel)
    }
    
    private func setupTopSpeed() {
        topSpeed.text = "326 KMPH"
        topSpeed.font = .systemFont(ofSize: 30, weight: .bold)
        topSpeed.textColor = .white
        
        infoStackView.addArrangedSubview(topSpeed)
    }
    
    private func setupRaceWeekendContainer() {
        raceWeekendContainer.layer.cornerRadius = 20
        raceWeekendContainer.layer.masksToBounds = true
        mainStackView.addArrangedSubview(raceWeekendContainer)
        
        let hostingController = UIHostingController(rootView: RaceWeekendView())
        hostingController.view.backgroundColor = .clear
        
        addChild(hostingController)
        raceWeekendContainer.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: raceWeekendContainer.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: raceWeekendContainer.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: raceWeekendContainer.topAnchor),
            hostingController.view.bottomAnchor.constraint(equalTo: raceWeekendContainer.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            raceWeekendContainer.leadingAnchor.constraint(equalTo: mainStackView.leadingAnchor, constant: -17),
            raceWeekendContainer.trailingAnchor.constraint(equalTo: mainStackView.trailingAnchor, constant: 17)
        ])
    }
}
