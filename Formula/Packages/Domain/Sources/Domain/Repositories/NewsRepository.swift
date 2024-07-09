//
//  File.swift
//  
//
//  Created by Bakar Kharabadze on 7/9/24.
//

import Foundation
import Common

public protocol NewsRepository {
    func getNews(query: String, from: String, sortBy: String, language: String, apiKey: String, with result: @escaping (Result<[NewsEntity], Error>) -> Void) -> Cancellable?
}
