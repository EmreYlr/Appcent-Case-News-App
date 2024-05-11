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
                    guard !data.articles.isEmpty else {
                        self?.currentPage -= 1
                        return
                    }
                    self?.newsItem.append(contentsOf: self?.filterData(data: data) ?? data.articles)
                    self?.delegate?.update()
                case .failure(let error):
                    print("Hata: \(error)")
                    self?.delegate?.error()
                }
            }
        }
    }
    
    func loadNextPage() {
        currentPage += 1
        fetchData(endpoint: .topHeadlines(country: .us))
    }
    
    private func filterData(data: News) -> [Article] {
        let dateFormatterInput = DateFormatter()
        dateFormatterInput.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let dateFormatterOutput = DateFormatter()
        dateFormatterOutput.dateFormat = "dd-MM-yyyy"
        
        return data.articles.map { article in
            var updatedArticle = article
            if let publishedAt = dateFormatterInput.date(from: article.publishedAt) {
                updatedArticle.publishedAt = dateFormatterOutput.string(from: publishedAt)
            }
            return updatedArticle
        }.filter { $0.title != "[Removed]" }
    }

}

extension HomeViewModel: HomeViewModelProtocol { }
