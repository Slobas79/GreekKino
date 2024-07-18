//
//  Configuration.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 18.7.24..
//

import Foundation

struct Configuration {
    
    static var apiBaseUrl: String {
        value(for: "API_BASE_URL")
    }
    
    static var numberOfrounds: Int {
        value(for: "NUMBER_OF_ROUNDS")
    }
    
    private static func value<T>(for key: String) -> T where T: LosslessStringConvertible {
        guard let object = Bundle.main.object(forInfoDictionaryKey:key) else {
            preconditionFailure("Missing key \(key)")
        }

        switch object {
        case let value as T:
            return value
        case let string as String:
            guard let value = T(string) else { fallthrough }
            return value
        default:
            preconditionFailure("Invalid value")
        }
    }
}
