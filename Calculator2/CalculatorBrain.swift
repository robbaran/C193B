//
//  CalculatorBrain.swift
//  Calculator2
//
//  Created by Robert Baranowski on 4/6/17.
//  Copyright © 2017 Robert Baranowski. All rights reserved.
//

import Foundation

struct CalculatorBrain {
    
    private var accumulaor : Double?    //this is the double that represents what is in the window
    
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
    
}