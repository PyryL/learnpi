//
//  DurationFormatterTest.swift
//  learnpiTests
//
//  Created by Pyry Lahtinen on 25.1.2024.
//

import XCTest
@testable import learnpi

final class DurationFormatterTests: XCTestCase {
    func testLessThanMinute() {
        XCTAssertEqual(DurationFormatter.format(27.418462), "27.4")
    }
    
    func testFractionRounding() {
        XCTAssertEqual(DurationFormatter.format(32.4846183), "32.5")
    }
    
    func testRoundingToNextSecond() {
        XCTAssertEqual(DurationFormatter.format(14.95132), "15.0")
    }
    
    func testRoundingToNextMinute() {
        XCTAssertEqual(DurationFormatter.format(59.951491), "1:00.0")
    }
    
    func testMultidigitMinutes() {
        XCTAssertEqual(DurationFormatter.format(747.5381931), "12:27.5")
    }
    
    func testZero() {
        XCTAssertEqual(DurationFormatter.format(0), "00.0")
    }
}
