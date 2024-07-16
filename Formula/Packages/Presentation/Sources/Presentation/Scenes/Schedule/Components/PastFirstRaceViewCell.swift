//
//  PastFirstRaceViewCell.swift
//
//
//  Created by Bakar Kharabadze on 7/7/24.
//

import UIKit
import SwiftUI
import Domain

class PastFirstRaceViewCell: UITableViewCell {
    private var hostingController: UIHostingController<PastFirstRace>?

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        backgroundColor = .clear // Cell background color set to clear
        guard let hostingView = hostingController?.view else { return }
        hostingView.backgroundColor = .clear // Hosting view background color set to clear
        contentView.addSubview(hostingView)
        hostingView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            hostingView.topAnchor.constraint(equalTo: contentView.topAnchor),
            hostingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            hostingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            hostingView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with race: RaceEntity) {
        let pastFirstRaceView = PastFirstRace(race: race)
        if let hostingController = hostingController {
            hostingController.rootView = pastFirstRaceView
        } else {
            let hostingController = UIHostingController(rootView: pastFirstRaceView)
            self.hostingController = hostingController
            guard let hostingView = hostingController.view else { return }
            hostingView.backgroundColor = .clear // Hosting view background color set to clear
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
