//
//  Zozor_Tests.swift
//  CountOnMeTests
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class Zozor_Tests: XCTestCase {

    func test_initCalculatorBrain_arrayNumbersContainsEmptyStringAndArrayOperatorContainPlus() {
        let sut = makeSUT()

        XCTAssertEqual(sut.stringNumbers, [""])
        XCTAssertEqual(sut.operators, ["+"])
        XCTAssertEqual(sut.isExpressionCorrect, .newCalcul)
        XCTAssertFalse(sut.canAddOperator)
    }

    func test_calcul_plusOperator() {
        // Arrange
        let sut = makeSUT()

        // Act
        sut.addNewNumber(.number(2))
        _ = sut.addNewOperator("+")
        XCTAssertFalse(sut.canAddOperator)
        sut.addNewNumber(.number(2))
        sut.calculateTotal()

        // Assert
        XCTAssertEqual(sut.result, "4.0")
    }

    func test_calcul_minusOperator() {
        // Arrange
        let sut = makeSUT()

        // Act
        sut.addNewNumber(.number(2))
        XCTAssertNil(sut.isExpressionCorrect)
        _ = sut.addNewOperator("-")
        XCTAssertFalse(sut.canAddOperator)
        sut.addNewNumber(.number(2))
        sut.calculateTotal()

        // Assert
        XCTAssertEqual(sut.result, "0.0")
    }

    func test_calculWithDot_PlusAndMinusOperatorGetDoubleResult() {
        // Arrange
        let sut = makeSUT()

        // Act
        sut.addNewNumber(.number(2))
        sut.addNewNumber(.dot("."))
        sut.addNewNumber(.number(8))
        _ = sut.addNewOperator("-")
        XCTAssertFalse(sut.canAddOperator)
        _ = sut.addNewOperator("-")
        XCTAssertEqual(sut.isExpressionCorrect, .correctExpression)
        sut.addNewNumber(.number(2))
        sut.addNewNumber(.dot("."))
        sut.addNewNumber(.number(6))
        sut.calculateTotal()

        // Assert
        XCTAssertEqual(sut.result, "0.2")
    }

    func test_clear_getEmptyArrays() {
        // Arrange
        let sut = makeSUT()

        // Act
        sut.addNewNumber(.number(2))
        _ = sut.addNewOperator("-")
        XCTAssertFalse(sut.canAddOperator)
        sut.addNewNumber(.number(2))
        sut.clear()

        // Assert
        XCTAssertEqual(sut.stringNumbers, [""])
        XCTAssertEqual(sut.operators, ["+"])
        XCTAssertFalse(sut.canAddOperator)
    }
    fileprivate func makeSUT() -> CalculatorBrainModel {
        return CalculatorBrainModel()
    }
}
