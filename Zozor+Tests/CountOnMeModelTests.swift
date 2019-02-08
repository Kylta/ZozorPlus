//
//  CountOnMeModelTests.swift
//  CountOnMeTests
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeModelTests: XCTestCase {

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
        XCTAssertTrue(sut.canAddOperator)
        XCTAssertEqual(sut.isExpressionCorrect, .correct)
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
        XCTAssertEqual(sut.isExpressionCorrect, .incorrectExpression)
        sut.addNewNumber(.number(2))
        _ = sut.addNewOperator(".")
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

    func test_updateDisplay_rendersString() {
        // Arrange
        let sut = makeSUT()

        // Act
        sut.addNewNumber(.number(2))
        XCTAssertEqual(sut.isExpressionCorrect, .correct)
        _ = sut.addNewOperator("-")
        XCTAssertFalse(sut.canAddOperator)
        sut.addNewNumber(.number(2))

        // Assert
        XCTAssertEqual(sut.updateDisplay(), "2-2")
    }

    func test_removeLastNumbers_removeLastNumberAndLastOperator() {
        // Arrange
        let sut = makeSUT()

        // Act
        sut.addNewNumber(.number(2))
        XCTAssertEqual(sut.isExpressionCorrect, .correct)
        _ = sut.addNewOperator("-")
        XCTAssertFalse(sut.canAddOperator)
        sut.addNewNumber(.number(2))
        _ = sut.removeLastNumbers()

        // Assert
        XCTAssertEqual(sut.updateDisplay(), "2")
    }

    fileprivate func makeSUT() -> CalculatorBrainModel {
        return CalculatorBrainModel()
    }
}
