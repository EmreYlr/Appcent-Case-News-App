//
//  DetailViewModel.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 11.05.2024.
//

import Foundation

protocol DetailViewModelProtocol { 
    var article: Article? { get set }
}

protocol DetailViewModelOutputProtocol: AnyObject {
    func update()
    func error()
}

final class DetailViewModel {
    var article: Article?
}

extension DetailViewModel : DetailViewModelProtocol { }
