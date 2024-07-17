//
//  NetworkingService.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation

protocol NetworkingService {
    func validateResponse(data: Data, response: URLResponse) throws
}

extension NetworkingService {
    func validateResponse(data: Data, response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkingError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw NetworkingError.requestFailed(statusCode: httpResponse.statusCode)
        }
    }
}
