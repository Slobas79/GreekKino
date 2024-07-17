//
//  RequestConvertible.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation

protocol RequestConvertible {
    func toURLRequest() throws -> URLRequest
}
