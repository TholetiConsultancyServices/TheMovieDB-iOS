//
//  MovieCollection.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation

struct MovieCollection: Codable {
    
    private(set) var parts: [Movie]?
    
    enum CodingKeys: String, CodingKey {
        case parts
    }
}
