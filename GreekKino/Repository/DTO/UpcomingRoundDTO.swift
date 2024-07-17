//
//  UpcomingRoundDTO.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation

struct UpcomingRoundDTO: Codable {
    let gameId: UInt
    let drawId: UInt
    let drawTime: Double
    let status: String
    let drawBreak: UInt
    let visualDraw: UInt
}
