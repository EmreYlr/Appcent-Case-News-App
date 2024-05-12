//
//  ViewController.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 9.05.2024.
//

import UIKit

final class HomeViewController: UIViewController {
    //MARK: -Properties
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var loadIndicator: UIActivityIndicatorView!
    
    
    var homeViewModel: HomeViewModelProtocol = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        homeViewModel.delegate = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
        homeViewModel.fetchData(endpoint: .topHeadlines(country: .us))
        searchBar.delegate = self
    }
    
    
}

//MARK: -HomeViewProtocolOutput
extension HomeViewController: HomeViewModelOutputProtocol {
    func startLoading() {
        loadIndicator.isHidden = false
        loadIndicator.startAnimating()
    }
    
    func stopLoading() {
        loadIndicator.isHidden = true
        loadIndicator.stopAnimating()
    }
    
    func update() {
        tableView.reloadData()
        print("Update")
    }
    
    func error() {
        print("Error")
    }
}
extension HomeViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        if let searchText = searchBar.text, !searchText.isEmpty {
            homeViewModel.fetchData(endpoint: .search(query: searchText))
            searchBar.text = ""
        }else {
            homeViewModel.fetchData(endpoint: .topHeadlines(country: .us))
        }
        searchBar.resignFirstResponder()
        tableView.reloadData()
        tableView.setContentOffset(CGPoint.zero, animated: true)
        
    }
    
    
}
