//
//  DetailViewModel.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 11.05.2024.
//

import Foundation

protocol DetailViewModelProtocol { 
    var article: Article? { get set }
    func saveToFavorites()
    func removeFromFavorites()
    func isArticleFavorite(_ article: Article) -> Bool 
}

final class DetailViewModel {
    var article: Article?
    //UserDefaults is used to store favorite articles
    func saveToFavorites() {
        guard let article = article else { return }
        let defaults = UserDefaults.standard
        var favorites = defaults.object(forKey: "favorites") as? [Data] ?? [Data]()
        if let encodedArticle = try? JSONEncoder().encode(article) {
            favorites.append(encodedArticle)
            defaults.set(favorites, forKey: "favorites")
        }
    }
    //Remove article from favorites
    func removeFromFavorites() {
        guard let article = article else { return }
        let defaults = UserDefaults.standard
        var favorites = defaults.object(forKey: "favorites") as? [Data] ?? [Data]()
        if let articleIndex = favorites.firstIndex(where: { data -> Bool in
            if let decodedArticle = try? JSONDecoder().decode(Article.self, from: data) {
                return decodedArticle.url == article.url
            }
            return false
        }) {
            favorites.remove(at: articleIndex)
            defaults.set(favorites, forKey: "favorites")
        }
    }
    //Check if article is favorite
    func isArticleFavorite(_ article: Article) -> Bool {
        let defaults = UserDefaults.standard
        if let favoritesData = defaults.object(forKey: "favorites") as? [Data] {
            for data in favoritesData {
                if let decodedArticle = try? JSONDecoder().decode(Article.self, from: data) {
                    if decodedArticle.url == article.url {
                        return true
                    }
                }
            }
        }
        return false
    }
}

extension DetailViewModel : DetailViewModelProtocol { }
