//
//  MovieDetailViewController.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewController: UIViewController {
    
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var subTextLabel: UILabel!
    
    @IBOutlet weak var collectionContainerView: UIView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBOutlet weak var moviesCollectionContainerViewHeightConstraint: NSLayoutConstraint!
    
    
    var viewModel : MovieDetailViewModel?
    private var movieCollectionViewController: MovieListViewController?
    
    static func viewController() -> MovieDetailViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: self)) as? MovieDetailViewController else {
            fatalError("Failed to create view controller from storyboard")
        }
        
        return viewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = "Movie Details"
        
        
        viewModel?.configureImageBlock = { [weak self] image in
            self?.posterImageView.image = image
            self?.posterImageView.showRoundCornersWith(radius: 20)
        }
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(loadMovieDetails))
        
        loadMovieDetails()
    }
    
    @objc private func loadMovieDetails() {
        
        disableControls()
        viewModel?.loadMovieDetails(completion: { [weak self] (status) in
            guard let strongSelf = self else { return }
            strongSelf.enableControls()
            switch status {
            case .successful:
                strongSelf.displayViewModel()
            case .failure(let error):
                Alert.present(withTitle: "Download Error", description: error, from: strongSelf)
                break
            }
        })
    }
    
    private func enableControls() {
        activityIndicator.stopAnimating()
    }
    
    private func disableControls() {
        activityIndicator.startAnimating()
    }
    
    private func displayViewModel() {
        guard let viewModel = viewModel else { return }
        titleLabel.text = viewModel.title
        subTitleLabel.text = viewModel.subTitle
        subTextLabel.text = viewModel.subText
        movieCollectionViewController?.viewModel = viewModel.movieCollectionViewModel
        moviesCollectionContainerViewHeightConstraint.isActive = (viewModel.movieCollectionViewModel != nil)
        view .setNeedsLayout()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard segue.identifier == "MovieListSegue",
            let movieCollectionViewController = segue.destination as? MovieListViewController else {
            return
        }
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        movieCollectionViewController.flowLayout = flowLayout
        self.movieCollectionViewController = movieCollectionViewController
    }
}

