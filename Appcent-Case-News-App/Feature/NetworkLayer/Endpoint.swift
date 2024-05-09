//
//  Endpoint.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 9.05.2024.
//

import Foundation
//MARK -Endpoint
enum Endpoint {
    case topHeadlines(country: Country)
    case search(query: String)
    case source

    func rawValue() -> String {
        switch self {
        case .topHeadlines(let country):
            return "top-headlines?country=\(country)"
        case .search(let query):
            return "everything?q=\(query)"
        case .source:
            return "sources"
        }
    }
}

enum Country: String {
    case tr = "tr"
    case us = "us"
}
