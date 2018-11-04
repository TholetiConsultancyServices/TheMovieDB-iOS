//
//  NowPlayingMoviesResponse.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//


import Foundation

struct NowPlayingMoviesResponse: Codable {

    private(set) var results: [Movie]?

    enum CodingKeys: String, CodingKey {
        case results
    }

}
