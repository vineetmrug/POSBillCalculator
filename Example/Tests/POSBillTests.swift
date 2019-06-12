//
//  POSBillTests.swift
//  POSBillCalculator_Tests
//
//  Created by Vineet Mrug on 2019-06-12.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import POSBillCalculator

class POSBillTests: XCTestCase {

    func testTotalCalculation() {
        let testSubtotal = NSDecimalNumber(mantissa: 7899, exponent: -2, isNegative: false)
        let testTotalTaxes = NSDecimalNumber(mantissa: 1245, exponent: -2, isNegative: false)
        let testTotalDiscounts = NSDecimalNumber(mantissa: 5, exponent: 0, isNegative: false)
        let totalValue = testSubtotal.adding(testTotalTaxes).subtracting(testTotalDiscounts)
        let expectedSanitizedTotalValue = totalValue.compare(NSDecimalNumber.zero) == ComparisonResult.orderedAscending ? NSDecimalNumber.zero : totalValue
        let testBill = POSBill(subtotal: testSubtotal, totalTaxes: testTotalTaxes, totalDiscounts: testTotalDiscounts)
        XCTAssertEqual(testBill.total, expectedSanitizedTotalValue)
    }
}
