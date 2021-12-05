//
//  MovieImageView.swift
//  Top250Movie_alamofire
//
//  Created by Руслан Сафин on 05.12.2021.
//

import UIKit

class MovieImageView: UIImageView {
    func fetchImage(from url: String) {
        guard let imageURL = URL(string: url) else { return
            image = #imageLiteral(resourceName: "NoImage")
        }
        
        // Use image from cache
        if let cachedImage = getCachedImage(from: imageURL) {
            image = cachedImage
            return
        }
        
        // Download image from url
        ImageNetwork.shared.fetchImage(from: imageURL) { data, response in
            
            // Save image to cache
            self.saveDataToCache(with: data, and: response)
            if imageURL.lastPathComponent == response.url?.lastPathComponent {
//                print("URL: ", imageURL.lastPathComponent)
                self.image = UIImage(data: data)
            }
        }
    }
    
    private func saveDataToCache(with data: Data, and response: URLResponse) {
        guard let url = response.url else { return }
        let cachedResponse = CachedURLResponse(response: response, data: data)
        let request = URLRequest(url: url)
        
        URLCache.shared.storeCachedResponse(cachedResponse, for: request)
    }
    
    private func getCachedImage(from url: URL) -> UIImage? {
        let request = URLRequest(url: url)
        guard let cachedResponse = URLCache.shared.cachedResponse(for: request) else { return nil }
        guard url.lastPathComponent == cachedResponse.response.url?.lastPathComponent else { return nil }
//        print("Cache: ", url.lastPathComponent)
        return UIImage(data: cachedResponse.data)
    }
}
