//
//  MovieServiceable.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation

enum MovieServicError {
    case none
    case networkOffline
    case cannotFetchData
}

enum MovieServicResult<T> {
    case Success(T)
    case Failure(MovieServicError)
}

protocol MovieServiceable {
    func fetchPosterImage(path: String, completionHandler: @escaping (Data?) -> Void)
    func fetchNowPlayingMovies(completionHandler: @escaping ([Movie]?, MovieServicError) -> Void)
    func fetchMovieDetails(from id: Int, completionHandler: @escaping (MovieDetails?, MovieServicError) -> Void)
    func fetchMovies(from collectionId: Int, completionHandler: @escaping ([Movie]?, MovieServicError) -> Void)
}
