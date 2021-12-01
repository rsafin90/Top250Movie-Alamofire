//
//  NetworkManager.swift
//  Top250Movie_alamofire
//
//  Created by Руслан Сафин on 30.11.2021.
//

import Foundation
import Alamofire

enum NetworkError: Error {
case invalidURL
case noData
case decodingError
}

class NetworkManager {
    
    // MARK: - Public properties
    static let shared = NetworkManager()
    
    // MARK: - Private properties
    private let urlAdress = "https://imdb-api.com/en/API/Top250Movies/k_a27czju9"
    
    private init() {}
    
    func getDataWithAlamofire(completion: @escaping(Result<[Movie], NetworkError>) -> Void) {
        AF.request(urlAdress)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let movies = Movie.getMovies(from: value)
                    completion(.success(movies))
                case .failure:
                    completion(.failure(.decodingError))
                }
            }
    }
    
}
