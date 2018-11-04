//
//  MovieDBTestBase.swift
//  TheMovieDBTests
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import XCTest

class TestUtils {
    
    func loadJson<T: Codable>(filename fileName: String) -> T? {
        let testBundle = Bundle(for: type(of: self))
        guard let url = testBundle.url(forResource: fileName, withExtension: "json") else {
            return nil
        }
        
        guard let data = try? Data(contentsOf: url) else {
            return nil
        }
        
        return T(jsonData: data)
    }
}
