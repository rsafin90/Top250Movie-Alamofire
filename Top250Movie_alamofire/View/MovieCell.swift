//
//  MovieCell.swift
//  Top250Movie_alamofire
//
//  Created by Руслан Сафин on 30.12.2021.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    // MARK: - Public properties
    var movie: Movie!
    
    // MARK: - Outlets
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var filmPoster: MovieImageView!
    
    // MARK: - Override
    override func layoutSubviews() {
        super.layoutSubviews()
        activityIndicator.startAnimating()
        activityIndicator.hidesWhenStopped = true
        
        if filmPoster.image != nil {
            self.activityIndicator.stopAnimating()
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        filmPoster.image = nil
    }
    
    func configure(with movie: Movie?) {
        filmPoster.fetchImage(from: movie?.image ?? "")
    }
}
