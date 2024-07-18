//
//  Int+Extensions.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 18.7.24..
//

import Foundation
import SwiftUI

extension Int {
    var resultColor: Color {
        switch self {
        case 1...10:
            return .R_1
        case 11...20:
            return .R_10
        case 21...30:
            return .R_20
        case 31...40:
            return .R_30
        case 41...50:
            return .R_40
        case 51...60:
            return .R_50
        case 61...70:
            return .R_60
        default:
            return .R_70
        }
    }
}
