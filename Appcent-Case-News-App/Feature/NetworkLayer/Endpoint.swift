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

    func rawValue() -> String {
        switch self {
        case .topHeadlines(let country):
            return "top-headlines?country=\(country)"
        case .search(let query):
            return "everything?q=\(query)"
        }
    }
}
//MARK -Country
enum Country: String {
    case tr = "tr"
    case us = "us"
}
