//
//  FavoritesViewModel.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 13.05.2024.
//

import Foundation

protocol FavoritesViewModelProtocol {
    var delegate: FavoritesViewModelOutputProtocol? { get set }
    func loadFavorites()
    var favorites: [Article] { get set }
}
protocol FavoritesViewModelOutputProtocol: AnyObject{
    func update()
    func error(error: ErrorTypes)
}

final class FavoritesViewModel {
    weak var delegate: FavoritesViewModelOutputProtocol?
    var favorites: [Article] = []
    //Used to show favorites stored in userdefaults
    func loadFavorites() {
        let defaults = UserDefaults.standard
        guard let favoriteDataArray = defaults.object(forKey: "favorites") as? [Data] else { return }
        favorites = favoriteDataArray.compactMap { data in
            if let article = try? JSONDecoder().decode(Article.self, from: data) {
                return article
            } else {
                delegate?.error(error: .invalidData)
                return nil
            }
        }
        delegate?.update()
    }
}

extension FavoritesViewModel: FavoritesViewModelProtocol { }
