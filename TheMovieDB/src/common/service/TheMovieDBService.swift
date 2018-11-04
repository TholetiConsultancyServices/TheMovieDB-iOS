//
//  TheMovieDBService.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/3/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit


private let apiKey = "f7ae5a29253b3db883e101050692f0a8"

struct TheMovieDBServiceEndPoints {
    static let theMoviesDB = "https://api.themoviedb.org/3"
    static let nowPlaying = "/movie/now_playing"
    static let posterImage = "http://image.tmdb.org/t/p/w185"
    static let movie = "/movie/"
    static let movieCollection = "/collection/"
}

struct TheMovieDBService: MovieServiceable {
    
    private let networkManager: NetworkManageable
    
    init(networkManager: NetworkManageable = NetworkManager()) {
        self.networkManager = networkManager
    }
    
    func fetchNowPlayingMovies(completionHandler: @escaping ([Movie]?, MovieServicError) -> Void) {
       
        guard let url =  self.requestURL(from: TheMovieDBServiceEndPoints.nowPlaying) else {
            completionHandler(nil, .cannotFetchData)
            return
        }

        networkManager.dowloadJSONData(with: url, requestHeaders: nil) { (result: Result<NowPlayingMoviesResponse>) in
            switch result {
            case .Success(let response):
                completionHandler(response.results, .none)
            case .Failure(let error):
                completionHandler(nil, error == .offline ? .networkOffline : .cannotFetchData )
            }
        }
    }
    
    func fetchPosterImage(path: String, completionHandler: @escaping (Data?) -> Void) {
    
        let urlString = TheMovieDBServiceEndPoints.posterImage.appending(path)
        guard let url =  URL(string: urlString) else {
            completionHandler(nil)
            return
        }
        
        networkManager.dowloadImageData(with: url, requestHeaders: nil) { (result: Result<Data>) in
            switch result {
            case .Success(let data):
                completionHandler(data)
            case .Failure(_):
                completionHandler(nil)
            }
        }
    }
    
    func fetchMovieDetails(from id: Int, completionHandler: @escaping (MovieDetails?, MovieServicError) -> Void) {
        
        let urlString = TheMovieDBServiceEndPoints.movie.appending(String(id))
        guard let url =  self.requestURL(from: urlString) else {
            completionHandler(nil, .cannotFetchData)
            return
        }
        
        networkManager.dowloadJSONData(with: url, requestHeaders: nil) { (result: Result<MovieDetails>) in
            switch result {
            case .Success(let response):
                completionHandler(response, .none)
            case .Failure(let error):
                completionHandler(nil, error == .offline ? .networkOffline : .cannotFetchData )
            }
        }
    }
    
    func fetchMovies(from collectionId: Int, completionHandler: @escaping ([Movie]?, MovieServicError) -> Void) {
        
        let urlString = TheMovieDBServiceEndPoints.movieCollection.appending(String(collectionId))
        guard let url =  self.requestURL(from: urlString) else {
            completionHandler(nil, .cannotFetchData)
            return
        }
        
        networkManager.dowloadJSONData(with: url, requestHeaders: nil) { (result: Result<MovieCollection>) in
            switch result {
            case .Success(let response):
                completionHandler(response.parts, .none)
            case .Failure(let error):
                completionHandler(nil, error == .offline ? .networkOffline : .cannotFetchData )
            }
        }
    }

}

extension TheMovieDBService {
   
    func requestURL(from path: String) -> URL? {
        
        let urlString = TheMovieDBServiceEndPoints.theMoviesDB.appending(path)
        guard let url = URL(string: urlString),
            var components = URLComponents(url: url, resolvingAgainstBaseURL: false)   else {
            return nil
        }
        
        let apiKeyItem = URLQueryItem(name: "api_key", value: apiKey)
        components.queryItems = [apiKeyItem]
        return components.url
        
    }
}

