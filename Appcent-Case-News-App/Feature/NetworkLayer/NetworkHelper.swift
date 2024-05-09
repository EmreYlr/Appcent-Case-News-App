//
//  NetworkHelper.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 9.05.2024.
//

import Foundation
import Alamofire

//MARK: -NetworkHelper
final class NetworkHelper {
    private static let BASE_URL = "https://newsapi.org/v2/"
    private static let API_KEY = "&apiKey=e6dfab9067f44cc29723b8e9606a9584"
    
    static func toURL(endpoint: Endpoint) -> URL? {
        return URL(string: NetworkHelper.BASE_URL + endpoint.rawValue() + NetworkHelper.API_KEY)
    }
}

//MARK: -HTTPMethods
enum HTTPMethods {
    case get
}

//MARK: -HTTPMethodsExtension
extension HTTPMethods {
    /// Converts to Alamofire's HTTPMethod.
    /// - Returns: Converted HTTPMethod.
    func toAlamofire() -> HTTPMethod {
        switch self {
        case .get:
            return .get
        }
    }
}

//MARK: -ErrorTypes
enum ErrorTypes: String,Error {
    case invalidData = "Invalid Data"
    case invalidURL = "Invalid URL"
}
