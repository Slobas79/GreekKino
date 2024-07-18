//
//  FetchRoundsUseCase.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation

protocol FetchUpcomingRoundsUseCase {
    func fetch(roundsNumber: Int) async throws -> [UpcomingRound]
}

class FetchUpcomingRoundsUseCaseImpl: FetchUpcomingRoundsUseCase {
    private let repo: OpapGRRepo
    
    init(repo: OpapGRRepo) {
        self.repo = repo
    }
    
    func fetch(roundsNumber: Int) async throws -> [UpcomingRound] {
        return try await repo.fetchUpcomingRounds(roundsNumber: roundsNumber)
            .map({
                UpcomingRound(drawId: $0.drawId, drawTime: Date(timeIntervalSince1970: $0.drawTime.toNumberOfSeconds()))
            })
    }
}

class FetchUpcomingRoundsUseCaseMock: FetchUpcomingRoundsUseCase {
    func fetch(roundsNumber: Int) async throws -> [UpcomingRound] {
        return [UpcomingRound(drawId: 1, drawTime: Date().advanced(by: 5 * 60)),
                UpcomingRound(drawId: 2, drawTime: Date().advanced(by: 10 * 60)),
                UpcomingRound(drawId: 3, drawTime: Date().advanced(by: 15 * 60)),
                UpcomingRound(drawId: 4, drawTime: Date().advanced(by: 20 * 60)),
                UpcomingRound(drawId: 5, drawTime: Date().advanced(by: 25 * 60)),
                UpcomingRound(drawId: 6, drawTime: Date().advanced(by: 30 * 60)),
                UpcomingRound(drawId: 7, drawTime: Date().advanced(by: 35 * 60)),
                UpcomingRound(drawId: 8, drawTime: Date().advanced(by: 40 * 60)),
                UpcomingRound(drawId: 9, drawTime: Date().advanced(by: 45 * 60)),
                UpcomingRound(drawId: 10, drawTime: Date().advanced(by: 50 * 60)),
                UpcomingRound(drawId: 11, drawTime: Date().advanced(by: 55 * 60)),
                UpcomingRound(drawId: 12, drawTime: Date().advanced(by: 60 * 60)),
                UpcomingRound(drawId: 13, drawTime: Date().advanced(by: 65 * 60)),
                UpcomingRound(drawId: 14, drawTime: Date().advanced(by: 70 * 60)),
                UpcomingRound(drawId: 15, drawTime: Date().advanced(by: 75 * 60)),
                UpcomingRound(drawId: 16, drawTime: Date().advanced(by: 80 * 60)),
                UpcomingRound(drawId: 17, drawTime: Date().advanced(by: 85 * 60)),
                UpcomingRound(drawId: 18, drawTime: Date().advanced(by: 90 * 60)),
                UpcomingRound(drawId: 19, drawTime: Date().advanced(by: 95 * 60)),
                UpcomingRound(drawId: 20, drawTime: Date().advanced(by: 100 * 60)),]
    }
}
