//
//  NetworkManager.swift
//  Top250Movie_alamofire
//
//  Created by Ruslan Safin on 30.11.2021.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL, noData, decodingError
}

class NetworkManager {
    
    static let shared = NetworkManager()
    
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

class ImageNetwork {
    static var shared = ImageNetwork()
    
    private init() {}
    
    func fetchImage(from url: URL, completion: @escaping (Data, URLResponse) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, let response = response else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            DispatchQueue.main.async {
                completion(data, response)
            }
        }.resume()
    }
}
