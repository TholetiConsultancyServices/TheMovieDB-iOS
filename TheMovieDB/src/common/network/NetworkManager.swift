//
//  NetworkManager.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/4/18.
// Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation


struct NetworkManager: NetworkManageable {
    
    private let cache: UrlDataChacheable
    
    init(cache: UrlDataChacheable = ImageCache()) {
        self.cache = cache
    }
    
    func dowloadJSONData<T: Codable>(with url: URL,
                                   requestHeaders:[String: String]?,
                                   completionHandler:@escaping (Result<T>)->Void) {
    
        let reachability = Reachability()
        guard reachability.isReachable == true else {
            completionHandler(.Failure(.offline))
            return
        }
        
        var request = URLRequest(url: url)
        if let headers = requestHeaders {
            for (header,value) in headers {
                request.addValue(value, forHTTPHeaderField: header)
            }
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Check network error
            guard error == nil else {
                completionHandler(.Failure(.networkRequestFailed))
                return
            }
            
            // Check JSON serialization error
            guard let unwrappedData = data else {
                completionHandler(.Failure(.jsonSerializationFailed))
                return
            }
            
            
             if let object = T(jsonData: unwrappedData) {
                completionHandler(.Success(object))
             } else {
                completionHandler(.Failure(.dataError))
            }
        }
        
        task.resume()
    }
    
    func dowloadImageData(with url: URL,
                                     requestHeaders:[String: String]?,
                                     completionHandler:@escaping (Result<Data>)->Void) {
        
        let reachability = Reachability()
        guard reachability.isReachable == true else {
            completionHandler(.Failure(.offline))
            return
        }
        
        var request = URLRequest(url: url)
        if let data = cache.cachedImageData(for: request) {
            completionHandler(.Success(data))
            return
        }
            
        if let headers = requestHeaders {
            for (header,value) in headers {
                request.addValue(value, forHTTPHeaderField: header)
            }
        }
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Check network error
            guard error == nil else {
                completionHandler(.Failure(.networkRequestFailed))
                return
            }
            
            guard let unwrappedData = data else {
                completionHandler(.Failure(.dataError))
                return
            }
            
            self.cache.storeImageData(data: data, request: request, response: response)
            completionHandler(.Success(unwrappedData))
         }
        
        task.resume()
    }
}
