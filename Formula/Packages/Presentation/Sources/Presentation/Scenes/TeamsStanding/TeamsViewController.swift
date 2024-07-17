//
//  TeamsViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/5/24.
//

import UIKit

public final class TeamsViewController: UIViewController {
    
    private let tableView = UITableView()
    private var viewModel: TeamsViewModel!

    public class func create(with viewModel: TeamsViewModel) -> TeamsViewController {
        let vc = TeamsViewController()
        vc.viewModel = viewModel
        return vc
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CustomBackground")
        navigationController?.navigationBar.barTintColor = UIColor(named: "CustomBackground")
        setupTableView()
        setupTitleLabel()
    }
    
    private func setupTableView() {
        tableView.register(TeamsTableViewCell.self, forCellReuseIdentifier: "TeamsTableViewCell")
        tableView.dataSource = self
        tableView.backgroundColor = UIColor(named: "CustomBackground")
        
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
    
    private func setupTitleLabel() {
        title = "Teams"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
    }
}

extension TeamsViewController: UITableViewDataSource {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.teams.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TeamsTableViewCell", for: indexPath) as! TeamsTableViewCell
        let team = viewModel.teams[indexPath.row]
        cell.configure(with: team, viewModel: viewModel)
        return cell
    }
}
