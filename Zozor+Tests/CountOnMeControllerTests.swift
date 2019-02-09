//
//  CountOnMeControllerTests.swift
//  CountOnMe
//
//  Created by Christophe Bugnon on 08/02/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import XCTest
@testable import CountOnMe

class CountOnMeControllerTests: XCTestCase {

    private let sb = UIStoryboard(name: "Main", bundle: nil)

    func test_initController_withDisplayedCalcul() {
        let sut = makeSUT()

        XCTAssertEqual(sut.textView.text, "1+1=2")
    }

    func test_DigitButtonTap_RenderNumberInDisplay() {
        let sampleNumbers = [0, 1, 2, 3, 4, 5, 6, 7, 8, 9]
        sampleNumbers.forEach { tag in
            let (sut, _) = expect(tag: tag)

            XCTAssertEqual(sut.textView.text, "\(tag)")
        }

        let samplesOperators = [".", "+", "-"]
        samplesOperators.forEach { _operator in
            let (sut, button) = expect(tag: 1)

            button.withTitle(_operator)
            sut.performOperator(button)

            XCTAssertEqual(sut.textView.text, "1\(button.currentTitle!)")
        }

        // "C"
        var (sut, button) = expect(tag: 1)

        button.withTitle("+")
        sut.performOperator(button)
        XCTAssertEqual(sut.textView.text, "1+")
        button.withTitle("C")
        sut.performOperator(button)

        XCTAssertEqual(sut.textView.text, "1")

        // "AC"
        (sut, button) = expect(tag: 1)

        button.withTitle("AC")
        sut.performOperator(button)

        XCTAssertEqual(sut.textView.text, "")
    }

    func test_calcul_displayResult() {
        let (sut, button) = expect(tag: 1)

        button.withTitle("+")
        sut.performOperator(button)
        button.withTag(2)
        sut.tappedNumberButton(button)
        sut.equal()

        XCTAssertEqual(sut.textView.text, "3.0")
    }

    func test_errors_displayedInViewController() {
        // new Calcul
        let sut1 = makeSUT()

        sut1.equal()

        XCTAssertEqual(sut1.calculatorBrain.isExpressionCorrect, .newCalcul)

        // Incorrect Expression
        let (sut2, button2) = expect(tag: 1)

        button2.withTitle("+")
        sut2.performOperator(button2)
        sut2.equal()

        XCTAssertEqual(sut2.calculatorBrain.isExpressionCorrect, .incorrectExpression)

        // Correct
        let (sut3, button3) = expect(tag: 1)

        button3.withTitle("+")
        sut3.performOperator(button3)
        button3.withTag(1)
        sut3.tappedNumberButton(button3)

        XCTAssertEqual(sut3.calculatorBrain.isExpressionCorrect, .correct)
    }

    private func expect(tag: Int) -> (sut: ViewController, button: UIButton) {
        let sut = makeSUT()
        let button = UIButton(type: .system)
        button.withTag(tag)
        sut.tappedNumberButton(button)

        return (sut, button)
    }

    private func makeSUT() -> ViewController {
        let sut = sb.instantiateInitialViewController() as! ViewController
        sut.loadViewIfNeeded()
        return sut
    }
}

private extension UIButton {
    func withTitle(_ title: String) {
        setTitle(title, for: .normal)
        sendActions(for: .touchUpInside)
    }

    func withTag(_ tag: Int) {
        self.tag = tag
        sendActions(for: .touchUpInside)
    }
}

