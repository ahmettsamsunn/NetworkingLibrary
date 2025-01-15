//
//  ResponseMetadata.swift
//  NetworkingLibrary
//
//  Created by Ahmet Samsun on 14.01.2025.
//
import Foundation

public struct ResponseMetadata: Decodable {
    public let timestamp: Date?
    public let requestId: String?
    public let status: Int?
    public let page: Int?
    public let totalPages: Int?
    public let totalItems: Int?
    
    enum CodingKeys: String, CodingKey {
        case timestamp
        case requestId = "request_id"
        case status
        case page
        case totalPages = "total_pages"
        case totalItems = "total_items"
    }
    
    public init(timestamp: Date? = nil,
               requestId: String? = nil,
               status: Int? = nil,
               page: Int? = nil,
               totalPages: Int? = nil,
               totalItems: Int? = nil) {
        self.timestamp = timestamp
        self.requestId = requestId
        self.status = status
        self.page = page
        self.totalPages = totalPages
        self.totalItems = totalItems
    }
}
