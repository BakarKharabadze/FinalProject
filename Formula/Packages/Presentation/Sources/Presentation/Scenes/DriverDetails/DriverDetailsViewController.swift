//
//  DriverDetailsViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//
import UIKit
import SwiftUI

public final class DriverDetailsViewController: UIViewController {
    
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    private let mainStackView = UIStackView()
    private let driverNameLabel = UILabel()
    private let driverNumberLabel = UILabel()
    private let teamNameLabel = UILabel()
    
    private var viewModel: DriverDetailsViewModel!
    
    public class func create(with viewModel: DriverDetailsViewModel) -> DriverDetailsViewController {
        let vc = DriverDetailsViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CustomBackground")
        navigationController?.navigationBar.barTintColor = UIColor(named: "CustomBackground")
        navigationController?.setNavigationBarHidden(false, animated: false)
        setupUI()
        setupSwiftUIHosting()
    }
    
    private func setupUI() {
        setupScrollView()
        setupContentView()
        setupMainStackView()
        setupDriverNameLabel()
        setupDriverNumberLabel()
        setupTeamNameLabel()
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
        mainStackView.spacing = 20
        
        NSLayoutConstraint.activate([
            mainStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            mainStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            mainStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func setupDriverNameLabel() {
        driverNameLabel.font = .systemFont(ofSize: 30, weight: .bold)
        driverNameLabel.textColor = .white
        driverNameLabel.text = "Max Verstappen"
        
        mainStackView.addArrangedSubview(driverNameLabel)
    }
    
    private func setupDriverNumberLabel() {
        driverNumberLabel.font = .systemFont(ofSize: 20)
        driverNumberLabel.textColor = .yellow
        driverNumberLabel.text = "1"
        
        mainStackView.addArrangedSubview(driverNumberLabel)
    }
    
    private func setupTeamNameLabel() {
        teamNameLabel.font = .systemFont(ofSize: 16)
        teamNameLabel.textColor = .lightGray
        teamNameLabel.text = "Red Bull Racing"
        
        mainStackView.addArrangedSubview(teamNameLabel)
    }
    
    private func setupSwiftUIHosting() {
        let swiftUIView = DriverDetailsSwiftUIView()
        let hostingController = UIHostingController(rootView: swiftUIView)
        
        addChild(hostingController)
        contentView.addSubview(hostingController.view)
        hostingController.didMove(toParent: self)
        
        hostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hostingController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hostingController.view.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 20),
            hostingController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}


#Preview {
    DriverDetailsViewController()
}
