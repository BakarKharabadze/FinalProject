//
//  TeamsViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/5/24.
//

import UIKit

class TeamsViewController: UIViewController {
    
    private let tableView = UITableView()
    private var drivers: [Driver] = []

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        
        drivers = [
            Driver(ranking: "01", name: "Red Bull", team: "RB20", points: 87, imageName: "Max"),
            Driver(ranking: "02", name: "Ferrari", team: "SF-24", points: 49, imageName: "Max"),
            Driver(ranking: "03", name: "Mclaren", team: "MCL38", points: 28, imageName: "Max"),
            Driver(ranking: "04", name: "Mercedes", team: "W15", points: 26, imageName: "Max"),
            Driver(ranking: "05", name: "Aston Martin", team: "AMR24", points: 13, imageName: "Max")
        ]

    }
    
    private func setupTableView() {
        tableView.register(TeamsTableViewCell.self, forCellReuseIdentifier: "TeamsTableViewCell")
        
        tableView.dataSource = self
        
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        tableView.reloadData()
    }
}

extension TeamsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        drivers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamsTableViewCell", for: indexPath) as! TeamsTableViewCell
        let driver = drivers[indexPath.row]
        cell.configure(with: driver)
        return cell
    }
}
