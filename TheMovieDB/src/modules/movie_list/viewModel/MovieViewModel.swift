//
//  MovieViewModel.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/3/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation
import UIKit

class MovieViewModel {

    private(set) var movie: Movie
    var image: UIImage?
    
    init(_ movie: Movie) {
        self.movie = movie
    }
    
    var title: String {
        return movie.title ?? ""
    }
    
    var subTitle: String {
        guard let date = movie.releaseDate else {
            return ""
        }
        return DateFormatter.string(from: date, format: "MMMM YYYY")
    }
    
    var imageUrl: String {
        return movie.posterPath ?? ""
    }
}
