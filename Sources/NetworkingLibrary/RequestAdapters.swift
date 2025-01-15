//
//  File 2.swift
//  NetworkingLibrary
//
//  Created by Ahmet Samsun on 14.01.2025.
//

import Foundation

public protocol RequestAdaptation {
    func adapt(request: URLRequest) -> URLRequest
}

public final class DefaultHTTPHeaderAdapter: RequestAdaptation {
    private var headerProvidingClosure: () -> [String: String]
    
    public init(headerProvidingClosure: @escaping () -> [String: String]) {
        self.headerProvidingClosure = headerProvidingClosure
    }

    public func adapt(request: URLRequest) -> URLRequest {
        var mutableRequest = request
        let headers = headerProvidingClosure()
        headers.forEach {
            mutableRequest.setValue($1, forHTTPHeaderField: $0)
        }
        return mutableRequest
    }
}
