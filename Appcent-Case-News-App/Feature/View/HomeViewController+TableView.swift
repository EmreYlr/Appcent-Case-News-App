//
//  HomeViewController+TableView.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 9.05.2024.
//

import Foundation
import UIKit

//MARK: -TableViewExtension
extension HomeViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        homeViewModel.newsItem.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! HomeTableViewCell
        let news = homeViewModel.newsItem[indexPath.row]
        cell.mainCellConfiguration(title: news.title, imageURL: news.urlToImage, description: news.description, date: news.publishedAt, source: news.source.id)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if indexPath.row == homeViewModel.newsItem.count - 1 {
            homeViewModel.loadNextPage()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 140
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let detailVC = storyboard.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        detailVC.detailViewModel.article = homeViewModel.newsItem[indexPath.row]
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}
