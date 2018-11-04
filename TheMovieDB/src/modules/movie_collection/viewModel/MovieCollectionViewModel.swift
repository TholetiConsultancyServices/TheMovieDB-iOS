//
//  MovieCollectionViewModel.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation

class MovieCollectionViewModel: BaseMovieListViewModel, MovieListViewModel {
    
    private let collectionId: Int
    required init(moviesService: MovieServiceable, collectionId: Int) {
        self.collectionId = collectionId
        super.init(moviesService: moviesService)
    }
    
    func loadMovies(completion: @escaping (DownloadStatus) -> Void) {
        moviesService.fetchMovies(from: collectionId) {[weak self] (movies, error) in
            DispatchQueue.main.async {
                switch error {
                case .none:
                    self?.movieViewModels =  movies?.map({ MovieViewModel($0) })
                    completion(.successful)
                case .cannotFetchData:
                    completion(.failure("Unable to load movies"))
                case .networkOffline:
                    completion(.failure("network in not avaible"))
                    
                }
            }
        }
    }
}
