//
//  AsyncNetworkingService.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation

protocol AsyncNetworkingService: NetworkingService {
    func request<T: Decodable>(_ returnType: T.Type, requestable: RequestConvertible) async throws -> T
}

class AsyncNetworkingServiceImpl: AsyncNetworkingService {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func request<T: Decodable>(_ returnType: T.Type, requestable: RequestConvertible) async throws -> T {
        let request = try requestable.toURLRequest()
        
        let (data, response) = try await session.data(for: request)
        
        try validateResponse(data: data, response: response)
        
        let decoder = JSONDecoder()
        
        do {
            let instance = try decoder.decode(returnType, from: data)
            return instance
        } catch {
            throw NetworkingError.deserializationError
        }
    }
}
