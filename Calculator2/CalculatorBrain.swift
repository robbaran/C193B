//
//  CalculatorBrain.swift
//  Calculator2
//
//  Created by Robert Baranowski on 4/6/17.
//  Copyright © 2017 Robert Baranowski. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulator : Double?    //this is the double that represents what is in the window
    
    private enum Operation {            //all possible types of operation the calc can do
        case constant(Double)       //some buttons' operation is just to type in a mathematical constant
        case unaryOperation((Double) -> Double)
        case binaryOperation((Double, Double) -> Double)
        case equals
    }
    
    private var operations : Dictionary<String, Operation> = [
        "π" : Operation.constant(Double.pi), //Double.pi is associated with constant
        "e" : Operation.constant(M_E),
        "√" : Operation.unaryOperation(sqrt),
        "cos" : Operation.unaryOperation(cos),
        "(-)" : Operation.unaryOperation({ -$0}),
        "+" : Operation.binaryOperation({$0 + $1}),
        "−" : Operation.binaryOperation({$0 - $1}),
        "×" : Operation.binaryOperation({$0 * $1}),
        "÷" : Operation.binaryOperation({$0 / $1}),
        "=" : Operation.equals
]
    mutating func setOperand(_ operand: Double) {
        accumulator = operand
    }
    
    mutating func performOperation(_ symbol : String) {
        if let operation = operations[symbol] { //if the symbol exists in operations dictionary
            switch operation {
            case .constant(let value):
                accumulator = value
            case .unaryOperation(let function):
                if accumulator != nil {
                    accumulator = function(accumulator!)
                }
            case .binaryOperation(let function):
                if accumulator != nil {
                    pbo = pendingBinaryOperation(function : function, firstOperand : accumulator!)
                    accumulator = nil
                }
            case .equals:
                performPendingBinaryOperation()
            }
        }
    }
    
    private var pbo : pendingBinaryOperation?    //this optional
    
    private struct pendingBinaryOperation{
        let function : (Double, Double) -> Double
        let firstOperand : Double
        func perform(with secondOperand : Double) -> Double {
            return function(firstOperand, secondOperand)
        }
    }
    
    private mutating func performPendingBinaryOperation() {
        if pbo != nil && accumulator != nil {
            accumulator = pbo!.perform(with: accumulator!)
            pbo = nil   //RJBadd: need to clear firstOperand!
        }
    }
    
    var result : Double? {
        get {
            return accumulator
        }
    }
}
