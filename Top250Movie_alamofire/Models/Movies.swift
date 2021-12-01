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
    
    static func getMovies(from value: (Any)) -> [Movie] {
        guard let jsonData = value as? [String: Any] else { return [] }
        guard let moviesData = jsonData["items"] as? [Any] else { return [] }
        
        var movies: [Movie] = []
        
        for item in moviesData {
            if let object = item as? [String: Any] {
                let movie = Movie(
                    fullTitle: object["fullTitle"] as? String ?? "N/A",
                    image: object["image"] as? String ?? "N/A")
                movies.append(movie)
            }
        }
        return movies
    }
}
