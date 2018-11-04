//
//  MovieDetailViewModel.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit

class MovieDetailViewModel {
    
    var movieCollectionViewModel: MovieListViewModel?
    var title: String?
    var subTitle: String?
    var subText: String?
    var image: UIImage?
    var configureImageBlock: ((UIImage) -> Void)?
    
    private let moviesService: MovieServiceable
    private let movieId: Int
    private var imageUrl: String?
    
    private var movieDetails: MovieDetails? {
        didSet {
            subText = movieDetails?.overview
            title = movieDetails?.title
            imageUrl = movieDetails?.posterPath
            if let date = movieDetails?.releaseDate {
                subTitle = DateFormatter.string(from: date, format: "MMMM YYYY")
            }
            if let collectionId = movieDetails?.belongsToCollection?.id {
                movieCollectionViewModel = MovieCollectionViewModel(moviesService: TheMovieDBService(networkManager: NetworkManager()), collectionId: collectionId)
            }
            loadImage { [weak self] (image) in
                if let image = image {
                    self?.configureImageBlock?(image)
                }
            }
        }
    }
    
    init( movieId: Int, moviesService: MovieServiceable) {
        self.moviesService = moviesService
        self.movieId = movieId
        
    }
    
    func loadMovieDetails(completion: @escaping (DownloadStatus) -> Void) {
        moviesService.fetchMovieDetails(from: movieId) {[weak self] (movieDetails, error) in
            DispatchQueue.main.async {
                switch error {
                case .none:
                    self?.movieDetails =  movieDetails
                    completion(.successful)
                case .cannotFetchData:
                    completion(.failure("Unable to load movie details, please try again."))
                case .networkOffline:
                    completion(.failure("Network in not available, Please check internet connection and try again."))
                }
            }
        }
    }
    
    private func loadImage(completion: @escaping (UIImage?) -> Void) {
        guard let imageUrl = imageUrl else {
            completion(nil)
            return
        }
        
        moviesService.fetchPosterImage(path: imageUrl) { [weak self] data in
            guard let imageData = data else { return }
            DispatchQueue.main.async {
                self?.image = UIImage(data: imageData)
                completion(self?.image)
            }
        }
    }
}
