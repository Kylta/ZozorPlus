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
    var result = ""

    var isExpressionCorrect: Error {
        if let stringNumber = stringNumbers.last,
            stringNumber.isEmpty {
            return stringNumbers.count == 1 ? .newCalcul : .incorrectExpression
        }
        return .correct
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
        case incorrectExpression
        case correct

        var title: String {
            return "Zéro!"
        }

        var message: String {
            switch self {
            case .newCalcul:
                return "Démarrez un nouveau calcul"
            case .incorrectExpression:
                return "Entrez une expression correcte !"
            case .correct:
                return ""
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
