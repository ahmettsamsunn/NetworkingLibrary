//
//  File.swift
//  NetworkingLibrary
//
//  Created by Ahmet Samsun on 14.01.2025.
//

import Foundation


public protocol RequestExecuting {
    func execute(_ request: URLRequest) async -> Result<ExecutionSuccessModel, Error>
}

public struct ExecutionSuccessModel {
    public let data: Data
    public let response: URLResponse
}

public final class RequestExecutor: RequestExecuting {
    private let session: URLSession

    public init(session: URLSession = .shared) {
        self.session = session
    }

    public func execute(_ request: URLRequest) async -> Result<ExecutionSuccessModel, Error> {
        do {
            let (data, response) = try await session.data(for: request)
            return .success(ExecutionSuccessModel(data: data, response: response))
        } catch {
            return .failure(error)
        }
    }
}
