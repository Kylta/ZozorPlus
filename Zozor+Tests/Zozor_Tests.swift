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

    fileprivate func makeSUT() -> CalculatorBrainModel {
        return CalculatorBrainModel()
    }
}
