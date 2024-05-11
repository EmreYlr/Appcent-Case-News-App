//
//  News.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 9.05.2024.
//

import Foundation

// MARK: - News
struct News: Codable {
    let totalResults: Int
    let articles: [Article]
}

// MARK: - Article
struct Article: Codable {
    let source: Source
    let author: String?
    let title: String
    let description: String?
    let url: String
    let urlToImage: String?
    var publishedAt: String
    let content: String?
}

// MARK: - Source
struct Source: Codable {
    let id: String?
    let name: String
}
