//
//  RaceDetailViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/14/24.
//


import UIKit

public class RaceDetailViewController: UIViewController {
    
    private var viewModel: RaceDetailViewModel!
    
    public class func create(with viewModel: RaceDetailViewModel) -> RaceDetailViewController {
        let vc = RaceDetailViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
    }
    
    private func setupUI() {
        let titleLabel = UILabel()
        titleLabel.text = viewModel.race.grandPrixName
        titleLabel.textAlignment = .center
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}



