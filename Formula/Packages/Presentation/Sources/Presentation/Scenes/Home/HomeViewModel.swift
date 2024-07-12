//
//  HomeViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import Foundation
import Domain
import Common

public protocol HomeViewModelDelegate: AnyObject {
    func newsFetched(_ news: [NewsEntity])
}

public enum HomeViewRoute {
    case showNewsDetail
}

public protocol HomeViewRouter {
    func perform(to: HomeViewRoute)
}

public final class HomeViewModel {
    public var router: HomeViewRouter?
    private let getNewsUseCase: GetNewsUseCase
    weak var delegate: HomeViewModelDelegate?
    
    public var drivers: [DriverEntity] = []
    public var news: [NewsEntity] = []
    
    public init(getNewsUseCase: GetNewsUseCase) {
        self.getNewsUseCase = getNewsUseCase
    }
    
    public func viewDidLoad() {
        fetchNews(query: "f1", from: "current", sortBy: "publishedAt", language: "en", apiKey: "57a97376638a49eeb91a6fd7dad7f1be")
    }
    
    public func fetchNews(query: String, from: String, sortBy: String, language: String, apiKey: String) {
        
        getNewsUseCase.execute(query: query, from: from, sortBy: sortBy, language: language, apiKey: apiKey) { [weak self] result in
            switch result {
            case .success(let news):
                self?.news = news
                DispatchQueue.main.async {
                    self?.delegate?.newsFetched(news)
                }
            case .failure(let error):
                print(error)
            }
        }
        
    }
    
}
