//
//  File.swift
//  NetworkingLibrary
//
//  Created by Ahmet Samsun on 14.01.2025.
//

import Foundation

/// A protocol that defines the requirements for a network request.
///
/// Implement this protocol to define the properties of your network requests,
/// such as the base URL, HTTP method, path, parameters, and headers.
///
/// Example usage:
/// ```swift
/// struct UserRequest: NetworkRequestable {
///     var baseURL: String { "https://api.example.com" }
///     var method: HTTPMethod { .get }
///     var path: String { "/users" }
/// }
/// ```
public protocol NetworkRequestable {
    /// The base URL for the request.
    var baseURL: String { get }
    
    /// The HTTP method to be used for the request.
    var method: HTTPMethod { get }
    
    /// The path component of the URL, which will be appended to the base URL.
    var path: String { get }
    
    /// Optional parameters to be included in the request.
    var parameters: Encodable? { get }
    
    /// Optional headers to be included in the request.
    var headers: [String: String]? { get }
}

public extension NetworkRequestable {
    var parameters: Encodable? { nil }
    var headers: [String: String]? { nil }
}
