//
//  NetworkingError.swift
//  NetworkingLibrary
//
//  Created by Ahmet Samsun on 14.01.2025.
//

import Foundation

public enum NetworkingError: Error {
    case requestCreationFailed(Error)
    case networkError(Error)
    case decodingFailed(Error)
    case invalidResponse
    case invalidURL
}
