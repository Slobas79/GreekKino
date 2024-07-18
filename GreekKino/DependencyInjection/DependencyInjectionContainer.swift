//
//  DependencyInjectionContainer.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 16.7.24..
//

import Foundation

final class DependencyInjectionContainer {
    private lazy var opapGRRepo: OpapGRRepo = OpapGRRepoImpl(asyncNetService: AsyncNetworkingServiceImpl())
    
    private(set) lazy var fetchUpcomingRoundsUseCase: FetchUpcomingRoundsUseCase = FetchUpcomingRoundsUseCaseImpl(repo: opapGRRepo)
    
    private(set) lazy var fetchRoundUseCase: FetchRoundUseCase = FetchRoundUseCaseImpl(repo: opapGRRepo)
    
    private(set) lazy var countDownUseCase: CountDownUseCase = CountDownUseCaseImpl()
    
    private(set) lazy var fetchResultsUseCase: FetchResultsUseCase = FetchResultsUseCaseImpl(repo: opapGRRepo)
}
