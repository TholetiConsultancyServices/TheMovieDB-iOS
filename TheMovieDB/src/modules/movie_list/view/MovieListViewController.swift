//
//  MovieListViewController.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import UIKit


class MovieListViewController: UIViewController {
    
    var viewModel: MovieListViewModel? {
        didSet {
            if isViewLoaded {
                loadMovies()
            }
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var flowLayout: UICollectionViewFlowLayout?  {
        didSet {
            if (viewIfLoaded != nil) {
                collectionView.collectionViewLayout = flowLayout!
            }
        }
    }
    
    private func defaultFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        title = viewModel?.title
        collectionView.collectionViewLayout = flowLayout ?? defaultFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MovieCollectionViewCell.nib, forCellWithReuseIdentifier: MovieCollectionViewCell.reuseIdentifier)
        activityIndicator.hidesWhenStopped = true
        loadMovies()
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(loadMovies))
    }
    
    @objc private func loadMovies() {
        guard let viewModel = viewModel else { return }
        
        disableControls()
        viewModel.loadMovies(completion: {[weak self] (status) in
            guard let strongSelf = self else { return }
            
            strongSelf.enableControls()
            switch status {
            case .successful:
                strongSelf.collectionView.reloadData()
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
}

extension MovieListViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = (collectionView.bounds.width - 40)/2
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20.0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0.0
    }
}

extension MovieListViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        guard let movieCell = cell as? MovieCollectionViewCell, let movieViewModels = viewModel?.movieViewModels else {
            return
        }
        let model = movieViewModels[indexPath.row]
        movieCell.displayModel(model)
        
        if let image = model.image {
            movieCell.updateImage(image: image)
        } else {
            viewModel?.loadImage(for: indexPath, completion: { [weak self] movie in
                if (self?.collectionView.indexPath(for: cell) as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                    movieCell.updateImage(image: movie.image!)
                }
            })
        }
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            self.loadImagesForOnscreenRows()
        }
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        self.loadImagesForOnscreenRows()
    }
    
    private func loadImagesForOnscreenRows() {
        guard let movies = viewModel?.movieViewModels,
            movies.count != 0 else { return }
        
        for indexPath in collectionView.indexPathsForVisibleItems {
            viewModel?.loadImage(for: indexPath, completion: { [weak self] movie in
                guard let cell = self?.collectionView.cellForItem(at: indexPath) as? MovieCollectionViewCell else { return }
                
                if (self?.collectionView.indexPath(for: cell) as NSIndexPath?)?.row == (indexPath as NSIndexPath).row {
                    cell.updateImage(image: movie.image!)
                }
            })
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard let movieDetailViewModel = viewModel?.movieDetail(for: indexPath) else {
            return
        }
        
        let detailViewController = MovieDetailViewController.viewController()
        detailViewController.viewModel = movieDetailViewModel
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
    
}

extension MovieListViewController: UICollectionViewDataSource {
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return collectionView.dequeueReusableCell(withReuseIdentifier: MovieCollectionViewCell.reuseIdentifier, for: indexPath)
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.movieViewModels?.count ?? 0
    }
}

