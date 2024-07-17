//
//  CountDownUseCase.swift
//  GreekKino
//
//  Created by Slobodan Stamenic on 17.7.24..
//

import Foundation
import Combine

protocol CountDownUseCase {
    var countDownPublisher: AnyPublisher<Date, Never> { get }
}

class CountDownUseCaseImpl: CountDownUseCase {
    private lazy var publisher: AnyPublisher<Date, Never> = {
        Timer.publish(every: 1, on: .main, in: .default)
            .autoconnect()
            .share()
            .eraseToAnyPublisher()
    }()
    
    var countDownPublisher: AnyPublisher<Date, Never> {
        return publisher
    }
}
