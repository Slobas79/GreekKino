//
//  ViewFactory.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation

final class ViewFactory {
    private let diContainer: DependencyInjectionContainer
    
    init(diContainer: DependencyInjectionContainer) {
        self.diContainer = diContainer
    }
    
    func createUpcomingRoundsScreen() -> UpcomingRoundsView {
        return UpcomingRoundsView(viewModel:
                                    UpcomingRoundsViewModel(fetchUseCase: diContainer.fetchUpcomingRoundsUseCase,
                                                            countDownController: diContainer.countDownController))
    }
    
    func createRoundScreen(roundId: UInt) -> RoundView {
        return RoundView(viewModel: RoundViewModel(roundId: roundId, fetchUseCase: diContainer.fetchRoundUseCase, countDownController: diContainer.countDownController, fetchResultsUseCase: diContainer.fetchResultsUseCase))
    }
}
