//
//  ResponseParser.swift.swift
//  NetworkingLibrary
//
//  Created by Ahmet Samsun on 14.01.2025.
//
import Foundation

public protocol ResponseParsing {
    func parseResult<T: Decodable>(_ result: Result<ExecutionSuccessModel, Error>) -> Result<SuccessResponseWrapper<T>, NetworkingError>
}

public final class ResponseParser: ResponseParsing {
    private let decoder: JSONDecoder
    
    public init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
        // Set snake case decoding strategy by default
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    public func parseResult<T: Decodable>(_ result: Result<ExecutionSuccessModel, Error>) -> Result<SuccessResponseWrapper<T>, NetworkingError> {
        switch result {
        case .success(let model):
            do {
                
                // Try to decode as SuccessResponseWrapper first
                let wrapper = try decoder.decode(SuccessResponseWrapper<T>.self, from: model.data)
                print("Successfully decoded response of type: \(T.self)")
                return .success(wrapper)
                
            } catch {
                print("Decoding error: \(error)")
                if let decodingError = error as? DecodingError {
                    switch decodingError {
                    case .keyNotFound(let key, let context):
                        print("Key '\(key)' not found: \(context.debugDescription)")
                    case .valueNotFound(let type, let context):
                        print("Value of type '\(type)' not found: \(context.debugDescription)")
                    case .typeMismatch(let type, let context):
                        print("Type mismatch for type '\(type)': \(context.debugDescription)")
                    default:
                        print("Other decoding error: \(decodingError)")
                    }
                }
                return .failure(.decodingFailed(error))
            }
        case .failure(let error):
            return .failure(.networkError(error))
        }
    }
}
