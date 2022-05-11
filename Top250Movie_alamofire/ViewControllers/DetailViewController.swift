//
//  DetailViewController.swift
//  Top250Movie_alamofire
//
//  Created by Ruslan Safin on 30.12.2021.
//

import UIKit

class DetailViewController: UIViewController {
    
    @IBOutlet weak var poster: UIImageView!
    @IBOutlet weak var mainLabel: UILabel!
    
    var movieLabel = ""
    var moviePoster: UIImage?
    
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
