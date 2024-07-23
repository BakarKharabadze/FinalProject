//
//  WebViewController.swift
//
//
//  Created by Bakar Kharabadze on 7/18/24.
//

import UIKit
import WebKit

final class WebViewController: UIViewController {
    
    //MARK: - Properties
    private let webView = WKWebView()
    private var url: URL
    
    //MARK: - Init
    init(url: URL) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupWebView()
        loadUrl()
    }
    
    //MARK: - Private Methods
    private func setupWebView() {
        view.addSubview(webView)
        webView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            webView.topAnchor.constraint(equalTo: view.topAnchor),
            webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            webView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            webView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func loadUrl() {
        let request = URLRequest(url: url)
        webView.load(request)
    }
}

class NoDoneButtonNavigationController: UINavigationController {
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationBar.topItem?.rightBarButtonItem = nil
    }
}




