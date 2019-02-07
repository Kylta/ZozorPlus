//
//  ViewController.swift
//  CountOnMe
//
//  Created by Ambroise COLLON on 30/08/2016.
//  Copyright © 2016 Ambroise Collon. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var calculatorBrain = CalculatorBrainModel()

    // MARK: - Outlets

    @IBOutlet weak var textView: UITextView! {
        didSet {
            textView.font = UIFont.systemFont(ofSize: textView.frame.height/4)
        }
    }

    @IBOutlet var numberButtons: [UIButton]!

    // MARK: - Action

    @IBAction func tappedNumberButton(_ sender: UIButton) {
        if let num = numberButtons.sorted(by: { $0.tag < $1.tag })
            .enumerated()
            .first(where: { sender.tag == $0.element.tag } ) {
            calculatorBrain.addNewNumber(.number(num.offset))
            textView.text = calculatorBrain.updateDisplay()
        }
    }

    @IBAction func performOperator(_ sender: UIButton) {
        switch sender.currentTitle {
        case "+":
            verifyCanAddOperator(_operator: sender.currentTitle!)
        case "-":
            verifyCanAddOperator(_operator: sender.currentTitle!)
        case "AC":
            clear()
        case "C":
            textView.text = calculatorBrain.removeLastNumbers()
        case ".":
            verifyCanAddOperator(_operator: sender.currentTitle!)
        default: break
        }
    }

    @IBAction func equal() {
        switch calculatorBrain.isExpressionCorrect {
        case .some(.newCalcul):
            createAlertController(error: calculatorBrain.isExpressionCorrect!)
        case .some(.correctExpression):
            createAlertController(error: calculatorBrain.isExpressionCorrect!)
        case .some(.incorrectExpression):
            createAlertController(error: calculatorBrain.isExpressionCorrect!)
        case .none:
            calculate()
        }
    }

    fileprivate func verifyCanAddOperator(_operator: String) {
        if calculatorBrain.canAddOperator {
            textView.text = calculatorBrain.addNewOperator(_operator)
        } else {
            createAlertController(error: .incorrectExpression)
        }
    }

    fileprivate func createAlertController(error: CalculError) {
        let alertVC = UIAlertController(title: error.title, message: error.message, preferredStyle: .alert)
        alertVC.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
        self.present(alertVC, animated: true, completion: nil)
    }

    fileprivate func calculate() {
        textView.text = calculatorBrain.calculateTotal()
        calculatorBrain.clear()
    }

    fileprivate func clear() {
        calculatorBrain.clear()
        textView.text = ""
    }
}
