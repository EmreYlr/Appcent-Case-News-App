//
//  FavoritesViewController.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 13.05.2024.
//

import UIKit

class FavoritesViewController: UIViewController {
    //MARK: -Properties
    @IBOutlet weak var tableView: UITableView!
    var favoritesViewModel: FavoritesViewModelProtocol = FavoritesViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initConfig()
        favoritesViewModel.loadFavorites()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.tabBar.isHidden = false
        favoritesViewModel.loadFavorites()
    }
    
    func initConfig() {
        tableView.delegate = self
        tableView.dataSource = self
        favoritesViewModel.delegate = self
        tableView.register(UINib(nibName: "HomeTableViewCell", bundle: nil), forCellReuseIdentifier: "cell")
    }
}

extension FavoritesViewController: FavoritesViewModelOutputProtocol {
    func update() {
        tableView.reloadData()
    }
    
    func error(error: ErrorTypes) {
        switch error {
        case .invalidData :
            showAlert(title: "Error", message: "Invalid data. Please check your internet connection")
        default:
            showAlert(title: "Error", message: "Unknown error occurred")
        }
    }
    
    
}
