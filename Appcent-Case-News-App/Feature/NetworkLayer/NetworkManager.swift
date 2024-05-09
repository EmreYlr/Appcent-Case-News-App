//
//  NetworkManager.swift
//  Appcent-Case-News-App
//
//  Created by Emre on 9.05.2024.
//

import Foundation
import Alamofire

//MARK: -NetworkManager
final class NetworkManager {
    //Singleton Pattern
    static let shared = NetworkManager()
    
    /// Sends a network request and processes its result.
    /// - Parameters:
    ///   - url: The URL to send the request to.
    ///   - method: HTTPSMethods Enum Value.
    ///   - completion: A closure to handle the request result.
    func request<T: Codable>(from url: URL ,method: HTTPMethods ,completion: @escaping(Result<T, ErrorTypes>) -> Void){
        AF.request(url, method: method.toAlamofire()).responseDecodable(of: T.self){ response in
            switch response.result{
            case .success(let value):
                completion(.success(value))
            case .failure(_):
                completion(.failure(.invalidURL))
                break
            }
        }
    }
}
