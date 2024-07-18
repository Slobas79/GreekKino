//
//  OpapGREndpoint.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation

enum OpapGREndpoint: Endpoint {
    case upcoming(rounds: Int = 20)
    case round(drawId: UInt)
    case results(from: Date, to: Date)
    
    var baseURL: String {
        return Configuration.apiBaseUrl
    }
    
    var relativeURL: String {
        switch self {
        case.upcoming(let rounds):
            return "/draws/v3.0/1100/upcoming/\(rounds)"
        case .round(let id):
            return "/draws/v3.0/1100/\(id)"
        case .results(let from, let to):
            return "/draws/v3.0/1100/draw-date/\(DateFormatter.yyyyMMdd.string(from: from))/\(DateFormatter.yyyyMMdd.string(from: to))"
        }
    }
    
    var method: String {
        return "get"
    }
    
    var headers: [String : String] {
        return ["Content-Type" : "application/json; charset=utf-8"]
    }
}
