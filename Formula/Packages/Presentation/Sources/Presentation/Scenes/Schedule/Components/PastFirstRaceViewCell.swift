//
//  PastFirstRaceViewCell.swift
//
//
//  Created by Bakar Kharabadze on 7/7/24.
//

import UIKit
import SwiftUI
import Domain

final class PastFirstRaceViewCell: UITableViewCell {
    
    // MARK: - Properties
    private var hostingController: UIHostingController<PastFirstRace>?

    // MARK: - Initialization
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    // MARK: - UI Setup
    private func setupUI() {
        backgroundColor = .clear
        guard let hostingView = hostingController?.view else { return }
        hostingView.backgroundColor = .clear
        contentView.addSubview(hostingView)
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hostingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    // MARK: - Configuration
    func configure(with race: RaceResultEntity) {
        let pastFirstRaceView = PastFirstRace(raceResult: race)
        if let hostingController = hostingController {
            hostingController.rootView = pastFirstRaceView
        } else {
            let hostingController = UIHostingController(rootView: pastFirstRaceView)
            self.hostingController = hostingController
            guard let hostingView = hostingController.view else { return }
            hostingView.backgroundColor = .clear
            contentView.addSubview(hostingView)
            hostingView.translatesAutoresizingMaskIntoConstraints = false
            NSLayoutConstraint.activate([
                hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
                hostingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
                hostingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
                hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
            ])
        }
    }
}
