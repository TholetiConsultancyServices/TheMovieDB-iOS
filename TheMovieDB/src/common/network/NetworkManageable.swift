//
//  NetworkManageable.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation

enum NetworkError {
    case offline
    case dataError
    case invalidCredentials
    case urlError
    case networkRequestFailed
    case jsonSerializationFailed
    case jsonParsingFailed
}

enum Result<T>{
    case Success(T)
    case Failure(NetworkError)
}


protocol NetworkManageable{
    
    func dowloadJSONData<T: Codable>(with url: URL,
                                     requestHeaders:[String: String]?,
                                     completionHandler:@escaping (Result<T>)->Void)
    
    func dowloadImageData(with url: URL,
                          requestHeaders:[String: String]?,
                          completionHandler:@escaping (Result<Data>)->Void)
}
