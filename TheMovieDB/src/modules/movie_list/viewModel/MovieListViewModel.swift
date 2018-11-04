//
//  MovieListViewModel.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit

enum DownloadStatus {
    case successful
    case failure(String)
}

protocol MovieListViewModel {
    var title: String? { get }
    var movieViewModels: [MovieViewModel]? { get }
    func movieDetail(for indexPath: IndexPath) -> MovieDetailViewModel?
    func loadImage(for indexPath: IndexPath, completion: @escaping (MovieViewModel) -> Void)
    func loadMovies(completion: @escaping (DownloadStatus) -> Void)
}

extension MovieListViewModel {
    var title: String? { return "" }
}


class BaseMovieListViewModel {
    
    let moviesService: MovieServiceable
    var movieViewModels: [MovieViewModel]?
    
    init(moviesService: MovieServiceable = TheMovieDBService()) {
        self.moviesService = moviesService
    }
    
    func movieDetail(for indexPath: IndexPath) -> MovieDetailViewModel? {
        guard let movieViewModel = movieViewModels?[indexPath.row] else {
            return nil
        }
        
        guard let movieId = movieViewModel.movie.id else { return nil }
        return MovieDetailViewModel(movieId: movieId, moviesService: moviesService)
    }
    
    func loadImage(for indexPath: IndexPath, completion: @escaping (MovieViewModel) -> Void) {
        guard let movieViewModels = movieViewModels else {
            return
        }
        
        let movieViewModel = movieViewModels[indexPath.row]
        moviesService.fetchPosterImage(path: movieViewModel.imageUrl) { data in
            guard let imageData = data else { return }
            DispatchQueue.main.async {
                movieViewModel.image = UIImage(data: imageData)
                completion(movieViewModel)
            }
        }
    }
}

