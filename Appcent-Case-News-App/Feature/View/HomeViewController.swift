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
        initConfig()
        homeViewModel.fetchData(endpoint: .topHeadlines(country: .us))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
    }
    
    func initConfig() {
        tableView.dataSource = self
        tableView.delegate = self
        searchBar.delegate = self
        homeViewModel.delegate = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
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
    }
    
    func error(error: ErrorTypes) {
        switch error {
        case .noData:
            showAlert(title: "Error", message: "This content is not available. Please try again with another word.")
            break
        case .invalidData:
            showAlert(title: "Error", message: "Invalid data. Please check your internet connection")
            break
        }
    }
}
//MARK: -UISeachBarDelegate
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
