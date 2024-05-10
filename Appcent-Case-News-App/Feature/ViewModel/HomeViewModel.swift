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
    func fetchData(endpoint: Endpoint)
    func loadNextPage()
}

protocol HomeViewModelOutputProtocol : AnyObject {
    func update()
    func error()
}

final class HomeViewModel {
    private(set) var newsItem:[Article] = []
    weak var delegate: HomeViewModelOutputProtocol?
    private var currentPage = 1
    
    func fetchData(endpoint: Endpoint) {
        if let url = NetworkHelper.toURL(endpoint: endpoint, page: currentPage) {
            NetworkManager.shared.request(from: url, method: .get) { [weak self] (result: Result<News, ErrorTypes>) in
                switch result {
                case .success(let data):
                    self?.newsItem.append(contentsOf: data.articles)
                    self?.delegate?.update()
                case .failure(let error):
                    print("Hata: \(error)")
                    self?.delegate?.error()
                }
            }
        }
    }
    
    func loadNextPage() {
        if newsItem.count % 20 != 0 {
            return
        }
        currentPage += 1
        fetchData(endpoint: .topHeadlines(country: .us))
    }
//        private func filterData(data: News) -> [Article] {
//            return data.articles.filter { $0.title != "[Removed]" }
//        }
}

extension HomeViewModel: HomeViewModelProtocol { }
