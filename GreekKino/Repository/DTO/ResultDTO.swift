//
//  ResultDTO.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 17.7.24..
//

import Foundation

struct WinningNumbersDTO: Codable {
    let list: [Int]
    let bonus: [Int]
}

struct ResultDTO: Codable {
    let gameId: UInt
    let drawId: UInt
    let drawTime: Double
    let status: String
    let drawBreak: UInt
    let visualDraw: UInt
    let winningNumbers: WinningNumbersDTO
}
