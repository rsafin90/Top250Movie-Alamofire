//
//  MovieCell.swift
//  Top250Movie_alamofire
//
//  Created by Руслан Сафин on 30.12.2021.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    @IBOutlet weak var filmPoster: UIImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    // MARK: - Override
    override func prepareForReuse() {
        super.prepareForReuse()
        filmPoster.image = nil
    }
    
    func configure(with movie: Movie ) {
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        DispatchQueue.global().async {
            guard let stringURL = movie.image else { return }
            guard let url = URL(string: stringURL) else { return }
            guard let imageData = try? Data(contentsOf: url) else { return }
            
            DispatchQueue.main.async {
                self.filmPoster.image = UIImage(data: imageData)
                self.activityIndicator.stopAnimating()
            }
        }
    }
}
