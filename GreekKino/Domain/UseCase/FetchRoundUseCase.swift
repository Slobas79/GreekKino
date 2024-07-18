//
//  FetchRoundUseCase.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 17.7.24..
//

import Foundation

protocol FetchRoundUseCase {
    func fetch(drawId: UInt) async throws -> Round
}

class FetchRoundUseCaseImpl: FetchRoundUseCase {
    private let repo: OpapGRRepo
    
    init(repo: OpapGRRepo) {
        self.repo = repo
    }
    
    func fetch(drawId: UInt) async throws -> Round {
        let value = try await repo.fetchRound(drawId: drawId)
        return Round(drawId: value.drawId, drawTime: Date(timeIntervalSince1970: value.drawTime.toNumberOfSeconds()))
    }
}

class FetchRoundUseCaseMock: FetchRoundUseCase {
    func fetch(drawId: UInt) async throws -> Round {
        return Round(drawId: 0, drawTime: Date())
    }
}
