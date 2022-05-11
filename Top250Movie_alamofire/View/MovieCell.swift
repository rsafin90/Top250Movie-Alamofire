//
//  MovieCell.swift
//  Top250Movie_alamofire
//
//  Created by Ruslan Safin on 30.12.2021.
//

import UIKit

class MovieCell: UICollectionViewCell {
    
    var movie: Movie!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var filmPoster: MovieImageView!
    
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
