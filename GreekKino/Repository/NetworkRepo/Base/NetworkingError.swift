//
//  NetworkingError.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation

enum NetworkingError: Error {
    case invalidURL
    case invalidResponse
    case requestFailed(statusCode: Int)
    case deserializationError
}
