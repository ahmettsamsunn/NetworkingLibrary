//
//  Untitled.swift
//  NetworkingLibrary
//
//  Created by Ahmet Samsun on 14.01.2025.
//

import Foundation

public struct SuccessResponseWrapper<T: Decodable>: Decodable {
    public let metadata: ResponseMetadata?
    public let response: T
    
    private enum CodingKeys: String, CodingKey {
        case metadata = "meta"
        case data
    }
    
    public init(from decoder: Decoder) throws {
        // First try to decode as a container with metadata
        if let container = try? decoder.container(keyedBy: CodingKeys.self),
           let _ = try? container.decodeIfPresent(ResponseMetadata.self, forKey: .metadata) {
            // Only use container decoding if we actually found metadata
            self.metadata = try container.decodeIfPresent(ResponseMetadata.self, forKey: .metadata)
            self.response = try container.decode(T.self, forKey: .data)
        } else {
            // If no metadata container found, decode the response directly
            self.metadata = nil
            self.response = try T(from: decoder)
        }
    }
    
    public init(response: T, metadata: ResponseMetadata? = nil) {
        self.response = response
        self.metadata = metadata
    }
}
