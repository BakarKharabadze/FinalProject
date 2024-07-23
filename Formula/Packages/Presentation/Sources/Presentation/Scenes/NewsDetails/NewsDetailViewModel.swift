//
//  NewsDetailViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import Foundation
import Domain

//MARK: - Protocol
public protocol NewsDetailViewModelDelegate: AnyObject {
    func imageFetched(_ imageData: Data?)
}

//MARK: - NewsDetailViewModel
public final class NewsDetailViewModel {
    
    //MARK: - Properties
    public weak var delegate: NewsDetailViewModelDelegate?
    public let news: NewsEntity
    
    //MARK: - Init
    public init(news: NewsEntity) {
        self.news = news
    }
    
    //MARK: - Methods
    public func fetchImage() {
        guard let urlToImage = news.urlToImage, let url = URL(string: urlToImage) else {
            delegate?.imageFetched(nil)
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                self.delegate?.imageFetched(nil)
                return
            }
            self.delegate?.imageFetched(data)
        }
        task.resume()
    }
}
