//
//  HomeViewModel.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 9.05.2024.
//

import Foundation

protocol HomeViewModelProtocol {
    var newsItem:[Article] { get }
    var delegate: HomeViewModelOutputProtocol? { get set }
    func fetchData()
}

protocol HomeViewModelOutputProtocol : AnyObject {
    func update()
    func error()
}

final class HomeViewModel {
    private(set) var newsItem:[Article] = []
    weak var delegate: HomeViewModelOutputProtocol?
    
    func fetchData() {
        if let url = NetworkHelper.toURL(endpoint:.topHeadlines(country: .tr)) {
            NetworkManager.shared.request(from: url, method: .get) { [weak self] (result: Result<News, ErrorTypes>) in
                switch result {
                case .success(let data):
                    self?.newsItem = data.articles
                    self?.delegate?.update()
                case .failure(let error):
                    print("Hata: \(error)")
                    self?.delegate?.error()
                }
            }
        }
    }
//    private func filterData(data: News) -> [News] {
//        return data.articles.filter { $0.title != "[Removed]" }
//    }
}

extension HomeViewModel: HomeViewModelProtocol {}
