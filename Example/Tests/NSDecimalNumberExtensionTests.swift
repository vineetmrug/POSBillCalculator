//
//  NSDecimalNumberExtensionTests.swift
//  POSBillCalculator_Tests
//
//  Created by Vineet Mrug on 2019-06-12.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import POSBillCalculator

class NSDecimalNumberExtensionTests: XCTestCase {
    
    func testCurrencyFormat() {
        let testDecimal = NSDecimalNumber(value: 7.9881924)
        let expectedOutput = NSDecimalNumber(mantissa: 799, exponent: -2, isNegative: false)
        XCTAssertEqual(testDecimal.currencyFormat(), expectedOutput)
    }

    func testCurrencyFormatString() {
        let testDecimal = NSDecimalNumber(value: 12.651432)
        let testLocale = Locale(identifier: "en_GB")
        let expectedOutput = "£12.65"
        XCTAssertEqual(testDecimal.currencyFormatString(locale: testLocale), expectedOutput)
    }
}
