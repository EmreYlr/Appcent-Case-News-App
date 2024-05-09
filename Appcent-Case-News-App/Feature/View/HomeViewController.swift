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
    var homeViewModel: HomeViewModelProtocol = HomeViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        homeViewModel.delegate = self
        homeViewModel.fetchData()
    }
}

//MARK: -HomeViewProtocolOutput
extension HomeViewController: HomeViewModelOutputProtocol {
    func update() {
        tableView.reloadData()
        print("Update")
    }
    
    func error() {
        print("Error")
    }
    
    
}
