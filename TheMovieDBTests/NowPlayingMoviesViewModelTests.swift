//
//  NowPlayingMoviesViewModelTests.swift
//  TheMovieDBTests
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import XCTest
@testable import TheMovieDB

class NowPlayingMoviesViewModelTests: XCTestCase {
    
    private var mockMovieService: MovieServiceable!
    private var nowPlayingMoviesViewModel: NowPlayingMoviesViewModel!
    
    override func setUp() {
        super.setUp()
        mockMovieService = MockMovieService()
        nowPlayingMoviesViewModel = NowPlayingMoviesViewModel(moviesService: mockMovieService)
        
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        nowPlayingMoviesViewModel = nil
        mockMovieService = nil
        super.tearDown()
    }
    
    func testLoadMoviesSuccesfully() {
        
        let promiseToCallBack = expectation(description: "calls back")
        
        nowPlayingMoviesViewModel.loadMovies(completion: { (status) in
            
            switch status {
            case .successful:
                XCTAssertEqual(self.nowPlayingMoviesViewModel.movieViewModels?.count, 20)
                let movieViewModel = self.nowPlayingMoviesViewModel.movieViewModels![0]
                XCTAssertNotNil(movieViewModel)
                XCTAssertEqual(movieViewModel.subTitle, "October 2018")
                XCTAssertEqual(movieViewModel.title, "Venom")
            case .failure(_):
                XCTFail("The result should be success")
            }
                
            promiseToCallBack.fulfill()
        })
        
     
        
        waitForExpectations(timeout: 2) { error in
            print("timed out: \(String(describing: error))" as Any)
        }
        
    }
    
}
