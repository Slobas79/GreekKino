//
//  RoundDTO.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 17.7.24..
//

import Foundation

struct RoundDTO: Codable {
    let gameId: UInt
    let drawId: UInt
    let drawTime: Double
    let status: String
    let drawBreak: UInt
    let visualDraw: UInt
}
