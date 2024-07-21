//
//  HighlightsViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/12/24.
//

import UIKit
import WebKit
import Domain

public final class HighlightsViewController: UIViewController {
    
    // MARK: - Properties
    private let mainStackView = UIStackView()
    private let logoImageView = UIImageView()
    private let highlightsTableView = UITableView()
    public var viewModel: HighlightsViewModel!
    
    // MARK: - Initialization
    public class func create(with viewModel: HighlightsViewModel) -> HighlightsViewController {
        let vc = HighlightsViewController(viewModel: viewModel)
        vc.viewModel = viewModel
        return vc
    }

    init(viewModel: HighlightsViewModel) {
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
        navigationController?.setNavigationBarHidden(true, animated: false)
        setupUI()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    // MARK: - Setup Functions
    private func setupUI() {
        setupMainStackView()
        setupLogoImageView()
        setupHighlightsTableView()
    }
    
    private func setupMainStackView() {
        view.addSubview(mainStackView)
        
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        mainStackView.axis = .vertical
        mainStackView.alignment = .leading
        mainStackView.distribution = .fill
        mainStackView.spacing = 10
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: -20),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func setupLogoImageView() {
        logoImageView.image = UIImage(named: "Youtube", in: Bundle.module, with: nil)
        logoImageView.contentMode = .scaleAspectFit
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        mainStackView.addArrangedSubview(logoImageView)
        
        NSLayoutConstraint.activate([
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.centerXAnchor.constraint(equalTo: mainStackView.centerXAnchor)
        ])
    }
    
    private func setupHighlightsTableView() {
        highlightsTableView.register(HighlightsTableViewCell.self, forCellReuseIdentifier: "HighlightsTableViewCell")
        highlightsTableView.dataSource = self
        highlightsTableView.delegate = self
        highlightsTableView.rowHeight = 340
        highlightsTableView.separatorStyle = .none
        highlightsTableView.backgroundColor = UIColor(named: "CustomBackground")
        
        view.addSubview(highlightsTableView)
        highlightsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highlightsTableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 5),
            highlightsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            highlightsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            highlightsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -10)
        ])
    }
    
    // MARK: - Video Handling
    private func openVideoOnYouTube(videoURL: URL) {
        let webViewController = WebViewController(url: videoURL)
        webViewController.modalPresentationStyle = .automatic
        present(webViewController, animated: true, completion: nil)
    }
}

// MARK: - UITableViewDataSource, UITableViewDelegate
extension HighlightsViewController: UITableViewDataSource, UITableViewDelegate {
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.videos.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "HighlightsTableViewCell", for: indexPath) as? HighlightsTableViewCell else {
            return UITableViewCell()
        }
        let highlight = viewModel.videos[indexPath.row]
        cell.configure(with: highlight)
        return cell
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let highlight = viewModel.videos[indexPath.row]
        guard let videoURL = URL(string: highlight.videoURL) else { return }
        openVideoOnYouTube(videoURL: videoURL)
    }
}

// MARK: - HighlightsViewModelDelegate
extension HighlightsViewController: HighlightsViewModelDelegate {
    public func videosFetched(_ videos: [VideosEntity]) {
        DispatchQueue.main.async {
            self.highlightsTableView.reloadData()
        }
    }
}
