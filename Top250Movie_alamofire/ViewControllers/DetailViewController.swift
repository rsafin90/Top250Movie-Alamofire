//
//  DetailViewController.swift
//  Top250Movie_alamofire
//
//  Created by Руслан Сафин on 30.12.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    
    // MARK: - Public properties
    var movieLabel = ""
    var moviePoster: UIImage?
    
    // MARK: - Override
    override func viewDidLoad() {
        super.viewDidLoad()
        mainLabel.text = movieLabel
        poster.image = moviePoster
    }
    
    @IBAction func tapToShare(_ sender: Any) {
        let shareController = UIActivityViewController(activityItems: [movieLabel, moviePoster!],
                                                       applicationActivities: nil)
        present(shareController, animated: true, completion: nil)
    }
}
