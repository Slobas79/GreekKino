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
                                    UpcomingRoundsViewModel(fetchUseCase: diContainer.getFetchUpcomingRoundsUseCase(),
                                                            countDownUseCase: diContainer.getCountDownUseCase()))
    }
    
    func createRoundScreen(roundId: UInt) -> RoundView {
        return RoundView(viewModel: RoundViewModel(roundId: roundId, fetchUseCase: diContainer.getFetchRoundUseCase(), countDownUseCase: diContainer.getCountDownUseCase()))
    }
}
