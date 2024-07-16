//
//  DefaultHomeViewRouter.swift
//
//
//  Created by Bakar Kharabadze on 7/9/24.
//


import UIKit

class DefaultHomeViewRouter: HomeViewRouter {
    
    weak var view: HomeViewController?
    let newsViewControllerFactory: NewsDetailViewControllerFactory
    
    init(view: HomeViewController,
         newsViewControllerFactory: NewsDetailViewControllerFactory) {
        self.view = view
        self.newsViewControllerFactory = newsViewControllerFactory
    }
    
    func perform(to route: HomeViewRoute) {
        switch route {
        case .showNewsDetail:
            guard let selectedNews = view?.viewModel.selectedNews else { return }
            let newsDetailViewModel = NewsDetailViewModel(news: selectedNews)
            let vc = newsViewControllerFactory.makeNewsDetailViewController(with: newsDetailViewModel)
            view?.navigationController?.pushViewController(vc, animated: false)
        }
    }
}
