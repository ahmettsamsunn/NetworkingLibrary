//
//  Networking.swift
//  NetworkingLibrary
//
//  Created by Ahmet Samsun on 14.01.2025.
//

import Foundation

public final class Networking {
    private let requestMaker: RequestMaking
    private let requestExecutor: RequestExecuting
    private let requestAdapters: [RequestAdaptation]
    private let responseParser: ResponseParsing
    private let session: URLSession
    
    public init(
        requestMaker: RequestMaking = RequestFactory(),
        requestExecutor: RequestExecuting = RequestExecutor(),
        requestAdapters: [RequestAdaptation] = [],
        responseParser: ResponseParsing = ResponseParser(),
        session: URLSession = .shared
    ) {
        self.requestMaker = requestMaker
        self.requestExecutor = requestExecutor
        self.requestAdapters = requestAdapters
        self.responseParser = responseParser
        self.session = session
    }
    
    public func executeRequest<T: Decodable, V: NetworkRequestable>(
        request: V,
        responseType: T.Type
    ) async -> Result<SuccessResponseWrapper<T>, NetworkingError> {
        do {
            // Create URLRequest
            let urlRequest = try requestMaker.makeURLRequest(with: request)
            
            // Apply request adapters
            var adaptedRequest = urlRequest
            requestAdapters.forEach {
                adaptedRequest = $0.adapt(request: adaptedRequest)
            }
            
            // Execute request
            let result = await requestExecutor.execute(adaptedRequest)
            
            // Parse and return result
            return responseParser.parseResult(result)
        } catch {
            return .failure(.requestCreationFailed(error))
        }
    }
    
    deinit {
        session.finishTasksAndInvalidate()
    }
}
