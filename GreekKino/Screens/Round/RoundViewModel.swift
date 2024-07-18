//
//  RoundViewModel.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 17.7.24..
//

import Foundation
import Combine

struct RoundInfo {
    let timeString: String
    let countDownString: String
    let id: UInt
    
    init(model: Round) {
        timeString = DateFormatter.HHmm.string(from: model.drawTime)
        let time = model.drawTime.timeIntervalSince(Date())
        countDownString = time > 0 ? time.toHHmmssString() : "00:00"
        id = model.drawId
    }
}

struct ResultItem: Hashable {
    let timeString: String
    let id: UInt
    let numbers: [Int]
    
    init(model: Result) {
        timeString = DateFormatter.ddMMHHmm.string(from: model.drawTime)
        id = model.drawId
        numbers = model.numbers
    }
}

@Observable class RoundViewModel {
    private let roundId: UInt
    private let fetchUseCase: FetchRoundUseCase
    private let fetchResultsUseCase: FetchResultsUseCase
    private let countDownUseCase: CountDownUseCase
    
    private(set) var errorMessage: String?
    private var round: Round?
    private(set) var roundInfo: RoundInfo?
    var selectedNumbers: [Int] = []
    
    private var results: [Result]?
    private(set) var resultsInfo: [ResultItem]?
    
    private var cancellable: Cancellable?
    
    init(roundId: UInt, fetchUseCase: FetchRoundUseCase, countDownUseCase: CountDownUseCase, fetchResultsUseCase: FetchResultsUseCase) {
        self.roundId = roundId
        self.fetchUseCase = fetchUseCase
        self.countDownUseCase = countDownUseCase
        self.fetchResultsUseCase = fetchResultsUseCase
    }
    
    func fetchRound() async {
        do {
            round = try await fetchUseCase.fetch(drawId: roundId)
            if let rnd = round {
                roundInfo = RoundInfo(model: rnd)
            }
            
            startTimer()
        } catch {
            errorMessage = "Dogodila se greska"
        }
    }
    
    func fetchResults() async {
        do {
            results = try await fetchResultsUseCase.fetch(from: Date(), to: Date())
            if let res = results {
                resultsInfo = res.map({ResultItem(model: $0)})
            }
        } catch {
            errorMessage = "Dogodila se greska"
        }
    }
    
    private func startTimer() {
        cancellable = nil
        cancellable = countDownUseCase.countDownPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                guard let self = self else { return }
                if let rnd = self.round {
                    roundInfo = RoundInfo(model: rnd)
                }
            }
    }
}
