//
//  CalculatorBrainModel.swift
//  CountOnMe
//
//  Created by Christophe Bugnon on 06/02/2019.
//  Copyright © 2019 Ambroise Collon. All rights reserved.
//

import Foundation

class CalculatorBrainModel {
    var stringNumbers: [String] = [String()]
    var operators: [String] = ["+"]
    var index = 0
    var result = ""

    var isExpressionCorrect: Error? {
        if let stringNumber = stringNumbers.last, stringNumber.isEmpty {
            if stringNumbers.count == 1 {
                return .newCalcul
            } else {
                return .correctExpression
            }
        }
        return nil
    }

    var canAddOperator: Bool {
        if let stringNumber = stringNumbers.last,
            stringNumber.isEmpty {
            return false
        }
        return true
    }

    enum ExpressionType {
        case number(Int)
        case dot(String)
    }

    enum Error: Swift.Error {
        case newCalcul
        case correctExpression
        case incorrectExpression

        var title: String {
            return "Zéro!"
        }

        var message: String {
            switch self {
            case .newCalcul:
                return "Démarrez un nouveau calcul"
            case .correctExpression:
                return "Entrez une expression correcte !"
            case .incorrectExpression:
                return "Expression incorrect !"
            }
        }
    }

    func removeLastNumbers() -> String {
        if stringNumbers.count > 1 {
            stringNumbers.removeLast()
            operators.removeLast()
        }
        return updateDisplay()
    }

    func clear() {
        stringNumbers = [String()]
        operators = ["+"]
        index = 0
    }

    func addNewOperator(_ newOperator: String) -> String {
        if newOperator == "." {
            addNewNumber(.dot(newOperator))
        } else {
            operators.append(newOperator)
            stringNumbers.append("")
        }
        return updateDisplay()
    }

    func addNewNumber(_ newNumber: ExpressionType) {
        if var stringNumber = stringNumbers.last {
            switch newNumber {
            case let .number(num):
                stringNumber += "\(num)"
                stringNumbers[stringNumbers.count-1] = stringNumber
            case let .dot(dot):
                stringNumber += "\(dot)"
                stringNumbers[stringNumbers.count-1] = stringNumber
            }
        }
    }

    func updateDisplay() -> String {
        var text = ""
        for (i, stringNumber) in stringNumbers.enumerated() {
            // Add operator
            if i > 0 {
                text += operators[i]
            }
            // Add number
            text += stringNumber
        }
        return text
    }

    func calculateTotal() {
        var total = 0.0
        for (i, stringNumber) in stringNumbers.enumerated() {
            if let number = Double(stringNumber) {
                if operators[i] == "+" {
                    total += number
                } else if operators[i] == "-" {
                    total -= number
                }
            }
        }

        self.result = String(Double(round(1000*total)/1000))
        sendNotification()
    }

    fileprivate func sendNotification() {
        let name = Notification.Name(rawValue: "resultReady")
        let notification = Notification(name: name)
        NotificationCenter.default.post(notification)
    }
}
