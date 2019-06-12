//
//  POSBillCalculatorTests.swift
//  POSBillCalculator_Tests
//
//  Created by Vineet Mrug on 2019-06-12.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import XCTest
@testable import POSBillCalculator

class POSBillCalculatorTests: XCTestCase {

    var testBillCalculator: POSBillCalculator!
    var testBillItems: [POSBillItem]!
    var testTaxes: [POSTax]!
    var testDiscounts: [POSDiscount]!
    
    override func setUp() {
        super.setUp()
        testBillCalculator = POSBillCalculator()
        let appetizers = POSCategory(id: "1", name: "Appetizers")
        let alcohol = POSCategory(id: "2", name: "Alcohol")
        testBillItems = [
            appetizers.addItem(itemId: "1", name: "Nachos", price: 13.99),
            appetizers.addItem(itemId: "2", name: "Calamari", price: 11.99),
            alcohol.addItem(itemId: "3", name: "Beer", price: 5.00)
        ]
        
        let tax1 = POSTax(id: "1", rate: 0.05, applicableCategoryIds: ["1","2"])
        let alcoholTax = POSTax(id: "2", rate: 0.1, applicableCategoryIds: ["2"])
        testTaxes = [tax1, alcoholTax]

        let discount10Dollars = POSDiscount(id: "1", type: POSDiscountType.dollars(amount: NSDecimalNumber(value: 10.00)))
        let discount20Percent = POSDiscount(id: "2", type: POSDiscountType.percent(rate: NSDecimalNumber(value: 0.2)))
        discount10Dollars.isEnabled = true
        discount20Percent.isEnabled = true
        testDiscounts = [discount10Dollars, discount20Percent]
    }

    override func tearDown() {
        testBillCalculator = nil
        testBillItems = nil
        testTaxes = nil
        testDiscounts = nil
        super.tearDown()
    }

    func testSubtotalCalculation() {
        let expectedSubtotal = NSDecimalNumber(mantissa: 3098, exponent: -2, isNegative: false)
        let generatedBill = testBillCalculator.generateBill(billItems: testBillItems, taxes: [], discounts: [])
        XCTAssertEqual(generatedBill.subtotal, expectedSubtotal)
    }

    func testTaxCalculation() {
        let expectedTotalTax = NSDecimalNumber(mantissa: 205, exponent: -2, isNegative: false)
        let generatedBill = testBillCalculator.generateBill(billItems: testBillItems, taxes: testTaxes, discounts: [])
        XCTAssertEqual(generatedBill.totalTaxes, expectedTotalTax)
    }

    func testDiscountCalculation() {
        let expectedTotalDiscount = NSDecimalNumber(mantissa: 142, exponent: -1, isNegative: false)
        let generatedBill = testBillCalculator.generateBill(billItems: testBillItems, taxes: [], discounts: testDiscounts)
        XCTAssertEqual(generatedBill.totalDiscounts, expectedTotalDiscount)
    }

    func testBillTotalCalculation() {
        let expectedTotal = NSDecimalNumber(mantissa: 1883, exponent: -2, isNegative: false)
        let generatedBill = testBillCalculator.generateBill(billItems: testBillItems, taxes: testTaxes, discounts: testDiscounts)
        XCTAssertEqual(generatedBill.total, expectedTotal)
    }
}
