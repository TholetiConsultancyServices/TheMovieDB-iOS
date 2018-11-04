//
//  MovieDetails.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation

class MovieDetails: Movie {
    
    var belongsToCollection: BelongsToCollection?
    
    // MARK: Codable Protocol
    private enum CodingKeys: String, CodingKey {
        case belongsToCollection = "belongs_to_collection"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        belongsToCollection = try? container.decode(.belongsToCollection)
        try super.init(from: decoder)
    }
    
    override func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(belongsToCollection, forKey: .belongsToCollection)
        try super.encode(to: encoder)
    }
    
}
