//
//  FetchResultsUseCase.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 18.7.24..
//

import Foundation

protocol FetchResultsUseCase {
    func fetch(from: Date, to:Date) async throws -> [Result]
}

class FetchResultsUseCaseImpl: FetchResultsUseCase {
    private let repo: OpapGRRepo
    
    init(repo: OpapGRRepo) {
        self.repo = repo
    }
    
    func fetch(from: Date, to: Date) async throws -> [Result] {
        return try await repo.fetchResults(from: from, to: to).content.map({
            Result(drawId: $0.drawId, drawTime: Date(timeIntervalSince1970: $0.drawTime.toNumberOfSeconds()), numbers: $0.winningNumbers.list)
        })
    }
}

class FetchResultsUseCaseMock: FetchResultsUseCase {
    func fetch(from: Date, to: Date) async throws -> [Result] {
        [Result(drawId: 0, drawTime: Date(), numbers: [11,2,31,48,56,64,73,80,19,10,21,32,13,67,55,43,77,18,3,20])]
    }
}
