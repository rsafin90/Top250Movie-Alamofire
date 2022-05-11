//
//  ViewController.swift
//  Top250Movie_alamofire
//
//  Created by Ruslan Safin on 30.11.2021.
//

import UIKit

class MainViewController: UICollectionViewController {
    
    private let itemsPerRow: CGFloat = 3
    private let sectionInsert = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
    private var movies: [Movie] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NetworkManager.shared.getDataWithAlamofire { result in
            switch result {
            case .success(let movies):
                self.movies = movies
                self.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int { movies.count }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "movieCell", for: indexPath) as! MovieCell
        let movie = movies[indexPath.item]
        
        cell.configure(with: movie)
        
        return cell
    }
    
    // MARK: Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let detailVC = segue.destination as! DetailViewController
        let cell = sender as! MovieCell
        let indexPath = self.collectionView.indexPath(for: cell)
        
        detailVC.movieLabel = movies[indexPath!.item].fullTitle!
        detailVC.moviePoster = cell.filmPoster.image
    }
}

// MARK: Extension CollectionView layout
extension MainViewController: UICollectionViewDelegateFlowLayout {
    
    // MARK: CollectionView size properties
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let paddingWidth = sectionInsert.left * (itemsPerRow + 1)
        let availableWidth = collectionView.frame.width - paddingWidth
        let widthPerItem = availableWidth / itemsPerRow
        
        return CGSize(width: widthPerItem, height: widthPerItem)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets { sectionInsert }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat { sectionInsert.left }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat { sectionInsert.left }
}
