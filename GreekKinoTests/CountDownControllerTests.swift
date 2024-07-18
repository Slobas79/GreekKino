//
//  CountDownControllerTests.swift
//  GreekKinoTests
//
//  Created by Slobodan Stamenic on 18.7.24..
//

import XCTest
import Combine
@testable import GreekKino

final class CountDownControllerTests: XCTestCase {

    var cancellables: Set<AnyCancellable> = []

    func testCountDownPublisherEmitsDates() {
        let controller = CountDownControllerImpl()
        var emittedDates: [Date] = []
        let expectation = self.expectation(description: "Publisher emits dates")
        
        controller.countDownPublisher
            .sink { date in
                emittedDates.append(date)
                if emittedDates.count == 3 {
                    expectation.fulfill()
                }
            }
            .store(in: &cancellables)
        
        waitForExpectations(timeout: 4) { error in
            XCTAssertNil(error, "Test timed out")
            XCTAssertEqual(emittedDates.count, 3, "Expected 3 dates to be emitted")
        }
    }
}
