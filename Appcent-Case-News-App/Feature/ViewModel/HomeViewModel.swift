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
    func startLoading()
    func stopLoading()
    func error(error: ErrorTypes)
}

final class HomeViewModel {
    private(set) var newsItem:[Article] = []
    weak var delegate: HomeViewModelOutputProtocol?
    private var tempEndpoint: Endpoint = .topHeadlines(country: .us)
    private var currentPage = 1
    private let networkManager: NetworkManagerProtocol
    
    init(networkManager: NetworkManagerProtocol = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchData(endpoint: Endpoint) {
        if tempEndpoint.rawValue() != endpoint.rawValue() {
            delegate?.startLoading()
            currentPage = 1
            newsItem.removeAll()
        }
        if let url = NetworkHelper.toURL(endpoint: endpoint, page: currentPage) {
            networkManager.request(from: url, method: .get) { [weak self] (result: Result<News, ErrorTypes>) in
                switch result {
                case .success(let data):
                    if data.totalResults == 0 {
                        self?.delegate?.error(error: ErrorTypes.noData)
                        self?.delegate?.stopLoading()
                        return
                    }
                    guard !data.articles.isEmpty else {
                        self?.currentPage -= 1
                        self?.delegate?.stopLoading()
                        return
                    }
                    self?.delegate?.startLoading()
                    self?.newsItem.append(contentsOf: self?.filterData(data: data) ?? data.articles)
                    self?.delegate?.update()
                case .failure(_):
                    self?.delegate?.error(error: ErrorTypes.invalidData)
                }
                self?.delegate?.stopLoading()
            }
        }
        tempEndpoint = endpoint
    }
    //Pagination
    func loadNextPage() {
        currentPage += 1
        fetchData(endpoint: tempEndpoint)
    }
    //Date formater and "Removed" data clear
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
