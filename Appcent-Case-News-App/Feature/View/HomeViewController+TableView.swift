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
        let cell = UITableViewCell()
        var context = cell.defaultContentConfiguration()
        context.text = homeViewModel.newsItem[indexPath.row].title
        context.secondaryText = homeViewModel.newsItem[indexPath.row].description
        cell.contentConfiguration = context
        return cell
    }
}
