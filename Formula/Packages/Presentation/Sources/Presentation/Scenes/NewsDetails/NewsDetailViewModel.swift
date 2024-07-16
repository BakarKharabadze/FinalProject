//
//  NewsDetailViewModel.swift
//
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import Foundation
import Domain

import Foundation

public protocol NewsDetailViewModelDelegate: AnyObject {
    func imageFetched(_ imageData: Data?)
}

public class NewsDetailViewModel {
    public let news: NewsEntity
    public weak var delegate: NewsDetailViewModelDelegate?
    
    public init(news: NewsEntity) {
        self.news = news
    }
    
    public var imageUrl: URL? {
        return URL(string: news.urlToImage ?? "")
    }
    
    public func fetchImage() {
        guard let imageUrl = imageUrl else {
            delegate?.imageFetched(nil)
            return
        }
        
        URLSession.shared.dataTask(with: imageUrl) { [weak self] data, response, error in
            guard let self = self else { return }
            guard let data = data, error == nil else {
                self.delegate?.imageFetched(nil)
                return
            }
            self.delegate?.imageFetched(data)
        }.resume()
    }
}
