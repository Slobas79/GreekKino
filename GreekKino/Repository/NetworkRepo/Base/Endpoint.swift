//
//  Endpoint.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation

protocol Endpoint: RequestConvertible {
    var baseURL: String { get }
    var relativeURL: String { get }
    var method: String { get }
    var headers: [String : String] { get }
}

extension Endpoint {
    func toURLRequest() throws -> URLRequest {
        guard let url = URL(string: baseURL + relativeURL) else {
            throw NetworkingError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method
        
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        return request
    }
}
