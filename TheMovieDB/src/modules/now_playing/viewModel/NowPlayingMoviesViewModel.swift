//
//  NowPlayingMoviesViewModel.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/3/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit


class NowPlayingMoviesViewModel: BaseMovieListViewModel, MovieListViewModel {
    
    var title: String? { return "Now Playing" }
    
    func loadMovies(completion: @escaping (DownloadStatus) -> Void) {
        moviesService.fetchNowPlayingMovies {[weak self] (movies, error) in
            
            DispatchQueue.main.async {
                switch error {
                case .none:
                    self?.movieViewModels =  movies?.map({ MovieViewModel($0) })
                    completion(.successful)
                case .cannotFetchData:
                    completion(.failure("Unable to load movies, please try again."))
                case .networkOffline:
                    completion(.failure("Network in not available, Please check internet connection and try again."))
                    
                }
            }
        }
    }
}
