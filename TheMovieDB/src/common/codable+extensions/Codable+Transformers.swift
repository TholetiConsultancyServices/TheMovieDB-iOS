//
//  Codable+Transformers.swift
//  TheMovieDB
//
//  Created by Appaji Tholeti on 11/4/18.
//  Copyright © 2018 Appaji Tholeti. All rights reserved.
//

import Foundation

public typealias CodableTransformer = DecodingTransformer & EncodingTransformer

public protocol DecodingTransformer {
    associatedtype Input
    associatedtype Output
    func transform(_ decoded: Input) throws -> Output
}

public protocol EncodingTransformer {
    associatedtype Input
    associatedtype Output
    func transform(_ encoded: Output) throws -> Input
}

public extension KeyedDecodingContainer {

    public func decode<Transformer: DecodingTransformer>(_ key: KeyedDecodingContainer.Key,
                                                         transformer: Transformer) throws -> Transformer.Output where Transformer.Input : Decodable {
        let decoded: Transformer.Input = try self.decode(key)
        return try transformer.transform(decoded)
    }

    public func decode<T: Decodable>(_ key: KeyedDecodingContainer.Key) throws -> T {
        return try self.decode(T.self, forKey: key)
    }

}

public extension KeyedEncodingContainer {

    public mutating func encode<Transformer: EncodingTransformer>(_ value: Transformer.Output,
                                                                  forKey key: KeyedEncodingContainer.Key,
                                                                  transformer: Transformer) throws where Transformer.Input : Encodable {
        let transformed: Transformer.Input = try transformer.transform(value)
        try self.encode(transformed, forKey: key)
    }

}
