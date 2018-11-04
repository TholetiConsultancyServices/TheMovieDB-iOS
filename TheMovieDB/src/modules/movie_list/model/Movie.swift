//
//  Movie.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/3/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation


class Movie: Codable {
    
    var id: Int?
    var title: String?
    var posterPath: String?
    var overview: String?
    var releaseDate: Date?
    
    
    // MARK: Codable Protocol
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case posterPath = "poster_path"
        case overview
        case releaseDate = "release_date"
    }
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(.id)
        title = try? container.decode(.title)
        posterPath = try? container.decode(.posterPath)
        overview = try? container.decode(.overview)
        releaseDate = try? container.decode(.releaseDate, transformer: DateTransformer())
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(id, forKey: .id)
        try? container.encode(title, forKey: .title)
        try? container.encode(posterPath, forKey: .posterPath)
        try? container.encode(overview, forKey: .overview)
    }
}
