//
//  UpcomingRoundItemTest.swift
//  GreekKinoTests
//
//  Created by Slobodan Stamenic on 18.7.24..
//

import XCTest
@testable import GreekKino

final class UpcomingRoundItemTest: XCTestCase {
    func testPositiveCountdown() {
        let date = Date().addingTimeInterval(3600) // 1 hour from now
        let upcomingRound = UpcomingRound(drawId: 0, drawTime: date)
        let item = UpcomingRoundItem(model: upcomingRound)

        XCTAssertEqual(item.timeString, DateFormatter.HHmm.string(from: date))
        XCTAssertNotEqual(item.countDownString, "00:00")
        XCTAssertFalse(item.isRed)
        XCTAssertEqual(item.id, 0)
    }

    func testZeroCountdown() {
        let now = Date()
        let upcomingRound = UpcomingRound(drawId: 0, drawTime: now)
        let item = UpcomingRoundItem(model: upcomingRound)

        XCTAssertEqual(item.timeString, DateFormatter.HHmm.string(from: now))
        XCTAssertEqual(item.countDownString, "00:00")
        XCTAssertTrue(item.isRed)
        XCTAssertEqual(item.id, 0)
    }

    func testNegativeCountdown() {
        let pastDate = Date().addingTimeInterval(-3600) // 1 hour ago
        let upcomingRound = UpcomingRound(drawId: 0, drawTime: pastDate)
        let item = UpcomingRoundItem(model: upcomingRound)

        XCTAssertEqual(item.timeString, DateFormatter.HHmm.string(from: pastDate))
        XCTAssertEqual(item.countDownString, "00:00")
        XCTAssertTrue(item.isRed)
        XCTAssertEqual(item.id, 0)
    }

}
