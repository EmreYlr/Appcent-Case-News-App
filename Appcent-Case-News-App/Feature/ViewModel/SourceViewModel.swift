//
//  SourceViewModel.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 12.05.2024.
//

import Foundation

protocol SourceViewModelProtocol { 
    var articleUrl: URL? { get set }
}

final class SourceViewModel {
    var articleUrl: URL?
}

extension SourceViewModel: SourceViewModelProtocol { }
