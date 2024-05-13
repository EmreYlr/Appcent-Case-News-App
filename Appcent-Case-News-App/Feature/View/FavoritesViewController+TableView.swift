//
//  FavoritesViewController+TableView.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 13.05.2024.
//

import Foundation
import UIKit

//MARK: -TableViewExtension
extension FavoritesViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favoritesViewModel.favorites.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        let news = favoritesViewModel.favorites[indexPath.row]
        cell.mainCellConfiguration(title: news.title, imageURL: news.urlToImage, description: news.description, date: news.publishedAt, source: news.source.id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.detailViewModel.article = favoritesViewModel.favorites[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
