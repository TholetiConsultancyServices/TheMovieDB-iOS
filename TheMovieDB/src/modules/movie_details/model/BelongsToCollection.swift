//
//  MovieCollection.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation

struct BelongsToCollection: Codable {
    var id: Int?
    var name: String?
    var posterPath: String?
    
    // MARK: Codable Protocol
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case posterPath = "poster_path"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try? container.decode(.id)
        name = try? container.decode(.name)
        posterPath = try? container.decode(.posterPath)
      }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try? container.encode(id, forKey: .id)
        try? container.encode(name, forKey: .name)
        try? container.encode(posterPath, forKey: .posterPath)
    }
}
