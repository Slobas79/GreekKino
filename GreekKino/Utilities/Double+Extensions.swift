//
//  Double+Extensions.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 18.7.24..
//

import Foundation

private let numberOfMilisecondsPerSec: Double = 1000.00

extension Double {
    func toNumberOfSeconds() -> Double {
        return self/numberOfMilisecondsPerSec
    }
}
