//
//  File.swift
//  NetworkingLibrary
//
//  Created by Ahmet Samsun on 14.01.2025.
//

import Foundation

public protocol RequestMaking {
    func makeURLRequest<T: NetworkRequestable>(with request: T) throws -> URLRequest
}

public final class RequestFactory: RequestMaking {
    public init() {}

    public func makeURLRequest<T: NetworkRequestable>(with request: T) throws -> URLRequest {
        guard let url = URL(string: request.baseURL + request.path) else {
            throw URLError(.badURL)
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue
        
        if let headers = request.headers {
            headers.forEach { urlRequest.setValue($1, forHTTPHeaderField: $0) }
        }
        
        if let parameters = request.parameters {
            if request.method == .get {
                var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)!
                let queryParameters = try JSONSerialization.jsonObject(
                    with: JSONEncoder().encode(parameters),
                    options: .fragmentsAllowed
                ) as! [String: Any]
                
                urlComponents.queryItems = queryParameters.map {
                    if type(of: $0.value) == type(of: NSNumber(value: true)),
                       let value = $0.value as? Bool {
                        return URLQueryItem(name: $0.key, value: "\(value)")
                    }
                    return URLQueryItem(name: $0.key, value: String(describing: $0.value))
                }
                urlRequest.url = urlComponents.url
            } else {
                urlRequest.httpBody = try JSONEncoder().encode(parameters)
                urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
            }
        }
        
        return urlRequest

    }
}
