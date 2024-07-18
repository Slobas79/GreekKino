//
//  UpcomingRoundsViewModel.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation
import Combine

struct UpcomingRoundItem {
    let timeString: String
    let countDownString: String
    let isRed: Bool
    let id: UInt
    
    init(model: UpcomingRound) {
        timeString = DateFormatter.HHmm.string(from: model.drawTime)
        let time = model.drawTime.timeIntervalSince(Date())
        countDownString = time > 0 ? time.toHHmmssString() : "00:00"
        isRed = time <= 0
        id = model.drawId
    }
}

@Observable class UpcomingRoundsViewModel {
    private let numberOfRounds: Int = 20 //TO DO: move this to configuration
    private let fetchUseCase: FetchUpcomingRoundsUseCase
    private let countDownController: CountDownController
    
    
    private var upcomingRounds: [UpcomingRound] = []
    private(set) var upcomingRoundItems: [UpcomingRoundItem] = []
    private(set) var errorMessage: String?
    
    private var cancellable: Cancellable?
    
    init(fetchUseCase: FetchUpcomingRoundsUseCase, countDownController: CountDownController) {
        self.fetchUseCase = fetchUseCase
        self.countDownController = countDownController
    }
    
    func fetch() async {
        do {
            upcomingRounds = try await fetchUseCase.fetch(roundsNumber: numberOfRounds)
            upcomingRoundItems = upcomingRounds.map({UpcomingRoundItem(model: $0)})

            startTimer()
        } catch {
            errorMessage = "Dogodila se greska"
        }
    }
    
    private func startTimer() {
        cancellable = nil
        cancellable = countDownController.countDownPublisher
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                guard let self = self else { return }
                self.upcomingRoundItems = self.upcomingRounds.map({UpcomingRoundItem(model: $0)})
            }
    }
}
