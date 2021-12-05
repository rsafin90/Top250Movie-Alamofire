//
//  Movies.swift
//  Top250Movie_alamofire
//
//  Created by Руслан Сафин on 30.11.2021.
//

import Foundation

struct Movie: Decodable {
    let fullTitle: String?
    let image: String?
    
    init(movieData: [String: Any]) {
        fullTitle = movieData["fullTitle"] as? String
        image = movieData["image"] as? String
    }
    
    static func getMovies(from value: Any) -> [Movie] {
        guard let jsonData = value as? [String: Any] else { return [] }
        guard let moviesData = jsonData["items"] as? [Any] else { return [] }
        guard let object = moviesData as? [[String: Any]] else { return [] }
        
        return object.compactMap { Movie(movieData: $0) }
    }
}
