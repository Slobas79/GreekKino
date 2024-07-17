//
//  DependencyInjectionContainer.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation

final class DependencyInjectionContainer {
    private lazy var opapGRRepo: OpapGRRepo = OpapGRRepoImpl(asyncNetService: AsyncNetworkingServiceImpl())
    
    private lazy var fetchUpcomingRoundsUseCase: FetchUpcomingRoundsUseCase = FetchUpcomingRoundsUseCaseImpl(repo: opapGRRepo)
    func getFetchUpcomingRoundsUseCase() -> FetchUpcomingRoundsUseCase {
        return fetchUpcomingRoundsUseCase
    }
    
    private lazy var fetchRoundUseCase: FetchRoundUseCase = FetchRoundUseCaseImpl(repo: opapGRRepo)
    func getFetchRoundUseCase() -> FetchRoundUseCase {
        return fetchRoundUseCase
    }
    
    private lazy var countDownUseCase: CountDownUseCase = CountDownUseCaseImpl()
    func getCountDownUseCase() -> CountDownUseCase {
        return countDownUseCase
    }
}
