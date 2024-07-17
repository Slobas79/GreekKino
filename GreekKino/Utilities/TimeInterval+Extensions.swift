//
//  TimeInterval+Extensions.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation

extension TimeInterval {
    func toHHmmssString() -> String {
        let interval = Int(self)
        let hours = interval / 3600
        let minutes = (interval % 3600) / 60
        let seconds = interval % 60
        if hours > 0 {
            return String(format: "%0.2d:%0.2d:%0.2d", hours,minutes,seconds)
        }
        return String(format: "%0.2d:%0.2d", minutes,seconds)
    }
}
