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
    
    var baseURL: String {
        return "https://api.opap.gr" //TO DO: load this from configuration
    }
    
    var relativeURL: String {
        switch self {
        case.upcoming(let rounds):
            return "/draws/v3.0/1100/upcoming/\(rounds)"
        case .round(let id):
            return "/draws/v3.0/1100/\(id)"
        }
    }
    
    var method: String {
        return "get"
    }
    
    var headers: [String : String] {
        return ["Content-Type" : "application/json; charset=utf-8"]
    }
}
