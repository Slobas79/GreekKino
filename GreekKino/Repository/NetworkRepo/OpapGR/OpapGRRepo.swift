//
//  OpapGRRepo.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation

protocol OpapGRRepo {
    func fetchUpcomingRounds(roundsNumber: Int) async throws -> [UpcomingRoundDTO]
    func fetchRound(drawId: UInt) async throws -> RoundDTO
    func fetchResults(from: Date, to: Date) async throws -> [ResultDTO]
}

class OpapGRRepoImpl: OpapGRRepo {
    private let asyncNetService: AsyncNetworkingService
    
    init(asyncNetService: AsyncNetworkingService) {
        self.asyncNetService = asyncNetService
    }
    
    func fetchUpcomingRounds(roundsNumber: Int) async throws -> [UpcomingRoundDTO] {
        return try await asyncNetService.request([UpcomingRoundDTO].self, requestable: OpapGREndpoint.upcoming(rounds: roundsNumber))
    }
    
    func fetchRound(drawId: UInt) async throws -> RoundDTO {
        return try await asyncNetService.request(RoundDTO.self, requestable: OpapGREndpoint.round(drawId: drawId))
    }
    
    func fetchResults(from: Date, to: Date) async throws -> [ResultDTO] {
        return try await asyncNetService.request([ResultDTO].self, requestable: OpapGREndpoint.results(from: from, to: to))
    }
}
