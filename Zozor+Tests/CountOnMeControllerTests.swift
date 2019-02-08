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

    func test_initController_emptyScreen() {
        let sut = makeSUT()

        XCTAssertEqual(sut.textView.text, "1+1=2")
    }

    func test_DigitButtonTap_RenderNumberInDisplay() {
        // 0
        var (sut, button) = expect(tag: 0)
        XCTAssertEqual(sut.textView.text, "0")

        // "1"
        (sut, _) = expect(tag: 1)
        XCTAssertEqual(sut.textView.text, "1")

        // "2"
        (sut, _) = expect(tag: 2)
        XCTAssertEqual(sut.textView.text, "2")

        // "3"
        (sut, _) = expect(tag: 3)
        XCTAssertEqual(sut.textView.text, "3")

        // "4"
        (sut, _) = expect(tag: 4)
        XCTAssertEqual(sut.textView.text, "4")

        // "5"
        (sut, _) = expect(tag: 5)
        XCTAssertEqual(sut.textView.text, "5")

        // "6"
        (sut, _) = expect(tag: 6)
        XCTAssertEqual(sut.textView.text, "6")

        // "7"
        (sut, _) = expect(tag: 7)
        XCTAssertEqual(sut.textView.text, "7")

        // "8"
        (sut, _) = expect(tag: 8)
        XCTAssertEqual(sut.textView.text, "8")

        // "9"
        (sut, _) = expect(tag: 9)
        XCTAssertEqual(sut.textView.text, "9")

        // "."
        (sut, button) = expect(tag: 1)
        button.setTitle(".", for: .normal)
        button.sendActions(for: .touchUpInside)
        sut.performOperator(button)
        XCTAssertEqual(sut.textView.text, "1.")

        // "+"
        (sut, button) = expect(tag: 1)
        button.setTitle("+", for: .normal)
        button.sendActions(for: .touchUpInside)
        sut.performOperator(button)
        XCTAssertEqual(sut.textView.text, "1+")

        // "-"
        (sut, button) = expect(tag: 1)
        button.setTitle("-", for: .normal)
        button.sendActions(for: .touchUpInside)
        sut.performOperator(button)
        XCTAssertEqual(sut.textView.text, "1-")

        // "C"
        (sut, button) = expect(tag: 1)
        button.setTitle("+", for: .normal)
        button.sendActions(for: .touchUpInside)
        sut.performOperator(button)
        XCTAssertEqual(sut.textView.text, "1+")
        button.setTitle("C", for: .normal)
        button.sendActions(for: .touchUpInside)
        sut.performOperator(button)
        XCTAssertEqual(sut.textView.text, "1")

        // "AC"
        (sut, button) = expect(tag: 1)
        button.setTitle("AC", for: .normal)
        button.sendActions(for: .touchUpInside)
        sut.performOperator(button)
        XCTAssertEqual(sut.textView.text, "")

    }

    private func expect(tag: Int) -> (sut: ViewController, button: UIButton) {
        let sut = makeSUT()
        let button = UIButton(type: .system)
        button.tag = tag
        button.sendActions(for: .touchUpInside)
        sut.tappedNumberButton(button)

        return (sut, button)
    }

    private func makeSUT() -> ViewController {
        let sut = sb.instantiateInitialViewController() as! ViewController
        sut.loadViewIfNeeded()
        return sut
    }
}
