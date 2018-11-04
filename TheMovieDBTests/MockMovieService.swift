//
//  MockMovieService.swift
//  TheMovieDBTests
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import XCTest
@testable import TheMovieDB

class MockMovieService: MovieServiceable {
    func fetchNowPlayingMovies(completionHandler: @escaping ([Movie]?, MovieServicError) -> Void) {
        
        DispatchQueue.main.async {
            guard let response: NowPlayingMoviesResponse = TestUtils().loadJson(filename: "moviedb_now_playing") else {
                return
            }
            
            completionHandler(response.results, .none)
        }
    }
    
    
    func fetchPosterImage(path: String, completionHandler: @escaping (Data?) -> Void) {}
    func fetchMovieDetails(from id: Int, completionHandler: @escaping (MovieDetails?, MovieServicError) -> Void) {}
    func fetchMovies(from collectionId: Int, completionHandler: @escaping ([Movie]?, MovieServicError) -> Void) {}
   
    
}
