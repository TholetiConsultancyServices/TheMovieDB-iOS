//
//  NowPlayingMoviesResponseTests.swift
//  TheMovieDBTests
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import XCTest
@testable import TheMovieDB


class NowPlayingMoviesResponseTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNowPlayingMovieResponseModel() {
        guard let response: NowPlayingMoviesResponse = TestUtils().loadJson(filename: "moviedb_now_playing") else {
            XCTAssertThrowsError("unable to load file")
            return
        }
        XCTAssertEqual(response.results?.count, 20)
        let movie = response.results![0]
        XCTAssertEqual(movie.id, 335983)
        XCTAssertEqual(movie.title, "Venom")
        XCTAssertEqual(movie.posterPath, "/2uNW4WbgBXL25BAbXGLnLqX71Sw.jpg")
        guard let expectedData = try? DateTransformer().transform("2018-10-03") else {
            XCTAssertThrowsError("unable to convert date")
            return
        }
        
        XCTAssertEqual(movie.releaseDate,expectedData)

    }
    
}
