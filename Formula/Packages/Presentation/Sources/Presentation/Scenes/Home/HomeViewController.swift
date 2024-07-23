//
//  HomeViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/3/24.
//

import UIKit
import SwiftUI
import Domain

public final class HomeViewController: UIViewController {

    // MARK: - Properties
    private let tableView = UITableView()
    public var viewModel: HomeViewModel!

    // MARK: - Initialization
    public class func create(with viewModel: HomeViewModel, newsViewControllersFactory: NewsDetailViewControllerFactory) -> HomeViewController {
        let vc = HomeViewController(viewModel: viewModel)
        vc.viewModel.router = DefaultHomeViewRouter(view: vc, newsViewControllerFactory: newsViewControllersFactory)
        return vc
    }

    init(viewModel: HomeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life Cycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "CustomBackground")
        navigationController?.navigationBar.barTintColor = UIColor(named: "CustomBackground")
        setupUI()
        viewModel.delegate = self
        viewModel.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }

    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupNavigationBarLogo()
    }

    // MARK: - UI Setup
    private func setupUI() {
        setupTableView()
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        tableView.backgroundColor = UIColor(named: "CustomBackground")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "RaceViewCell")
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "TopDriversCell")
        tableView.register(NewsCell.self, forCellReuseIdentifier: "NewsCell")
        tableView.separatorStyle = .none
    }

    private func setupNavigationBarLogo() {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 150, height: 40))
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "Formula1Logo")
        navigationItem.titleView = imageView
    }

    // MARK: - Cell Configuration
    private func configureTitleCell(_ title: String) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = title
        cell.textLabel?.font = .systemFont(ofSize: 18)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        cell.contentView.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }

    private func configureRaceViewCell(_ tableView: UITableView, indexPath: IndexPath, race: RaceEntity) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "RaceViewCell", for: indexPath)
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        
        let raceViewHostingController = UIHostingController(rootView: RaceView(race: race))
        addChild(raceViewHostingController)
        cell.contentView.addSubview(raceViewHostingController.view)
        raceViewHostingController.view.backgroundColor = .clear
        raceViewHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            raceViewHostingController.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            raceViewHostingController.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            raceViewHostingController.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            raceViewHostingController.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])
        raceViewHostingController.didMove(toParent: self)
        return cell
    }

    private func configureTopDriversCell(_ tableView: UITableView, indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TopDriversCell", for: indexPath)
        cell.contentView.backgroundColor = .clear
        cell.backgroundColor = .clear        
        cell.selectionStyle = .none
        let topDriversHostingController = UIHostingController(rootView: TopDriversCoverFlowView(drivers: viewModel.drivers))
        addChild(topDriversHostingController)
        cell.contentView.addSubview(topDriversHostingController.view)
        topDriversHostingController.view.backgroundColor = .clear
        topDriversHostingController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            topDriversHostingController.view.topAnchor.constraint(equalTo: cell.contentView.topAnchor),
            topDriversHostingController.view.leadingAnchor.constraint(equalTo: cell.contentView.leadingAnchor),
            topDriversHostingController.view.trailingAnchor.constraint(equalTo: cell.contentView.trailingAnchor),
            topDriversHostingController.view.bottomAnchor.constraint(equalTo: cell.contentView.bottomAnchor)
        ])
        topDriversHostingController.didMove(toParent: self)
        return cell
    }


}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1:
            return 2
        case 2:
            return viewModel.news.count + 1
        default:
            return 0
        }
    }
    
    private func configureBoldTitleCell(_ title: String) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = title
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .clear
        cell.selectionStyle = .none
        return cell
    }

    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            if indexPath.row == 0 {
                return configureBoldTitleCell("Next Race")
            } else {
                if let race = viewModel.upcomingRace {
                    return configureRaceViewCell(tableView, indexPath: indexPath, race: race)
                } else {
                    return UITableViewCell()
                }
            }
        case 1:
            if indexPath.row == 0 {
                return configureBoldTitleCell("Top Drivers")
                
            } else {
                return configureTopDriversCell(tableView, indexPath: indexPath)
            }
        case 2:
            if indexPath.row == 0 {
                return configureBoldTitleCell("News")
            } else {
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCell", for: indexPath) as? NewsCell else {
                    return UITableViewCell()
                }
                cell.selectionStyle = .none
                let newsEntity = viewModel.news[indexPath.row - 1]
                cell.configure(with: newsEntity)
                return cell
            }
        default:
            return UITableViewCell()
        }
    }

    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 2 && indexPath.row > 0 {
            let selectedNews = viewModel.news[indexPath.row - 1]
            viewModel.newsViewTapped(news: selectedNews)
        }
    }
}

// MARK: - HomeViewModelDelegate
extension HomeViewController: HomeViewModelDelegate {
    public func raceFetched(_ race: RaceEntity) {
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet(integer: 0), with: .automatic)
        }
    }
    
    public func newsFetched(_ news: [NewsEntity]) {
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet(integer: 2), with: .automatic)
        }
    }

    public func driversFetched(_ drivers: [DriverEntity]) {
        DispatchQueue.main.async {
            self.tableView.reloadSections(IndexSet(integer: 1), with: .automatic)
        }
    }
}
