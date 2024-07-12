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
    
    private let mainStackView = UIStackView()
    private let titleLabel = UILabel()
    private let highlightsTableView = UITableView()
    private var webView: WKWebView?
    
    public var viewModel: HighlightsViewModel!
    
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
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        viewModel.delegate = self
        viewModel.viewDidLoad()
    }
    
    private func setupUI() {
        setupMainStackView()
        setupTitleLabel()
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
            mainStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
    
    private func setupTitleLabel() {
        titleLabel.text = "Highlights"
        titleLabel.font = .systemFont(ofSize: 24, weight: .bold)
        titleLabel.textAlignment = .left
        
        mainStackView.addArrangedSubview(titleLabel)
    }
    
    private func setupHighlightsTableView() {
        highlightsTableView.register(HighlightsTableViewCell.self, forCellReuseIdentifier: "HighlightsTableViewCell")
        highlightsTableView.dataSource = self
        highlightsTableView.delegate = self
        highlightsTableView.rowHeight = 220
        highlightsTableView.separatorStyle = .none
        
        view.addSubview(highlightsTableView)
        highlightsTableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            highlightsTableView.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 5),
            highlightsTableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            highlightsTableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            highlightsTableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20)
        ])
    }
    
    private func showVideoPlayer(videoId: String) {
        let videoURLString = "https://www.youtube.com/embed/\(videoId)"
        guard let videoURL = URL(string: videoURLString) else { return }
        
        let webView = WKWebView()
        webView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(webView)
        
        NSLayoutConstraint.activate([
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        let request = URLRequest(url: videoURL)
        webView.load(request)
        
        self.webView = webView
    }
}

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
        showVideoPlayer(videoId: highlight.fetchedVideosId)
    }
}

extension HighlightsViewController: HighlightsViewModelDelegate {
    public func videosFetched(_ videos: [VideosEntity]) {
        DispatchQueue.main.async {
            self.highlightsTableView.reloadData()
        }
    }
}
