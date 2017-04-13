//
//  ViewController.swift
//  Calculator2
//
//  Created by Robert Baranowski on 4/6/17.
//  Copyright © 2017 Robert Baranowski. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var display: UILabel!
    
    @IBOutlet weak var sequence: UILabel!
    
    var userIsInTheMiddleOfTyping = false
    var userHasTypedDecimal = false
    
    @IBAction func touchDigit(_ sender: UIButton) {
        let digit = sender.currentTitle!
        if digit == "." {
            if userHasTypedDecimal {
                return   //ignore this decimal
            }
            else {
                userHasTypedDecimal = true
            }
        }
        if userIsInTheMiddleOfTyping {
            let textCurrentlyInDisplay = display.text!
            //if there is decimal in textCurrentlyInDisplay, ignore digit if it is another decimal
            //
                display.text = textCurrentlyInDisplay + digit
        }
        else {
            display.text = digit   //only when starting up, removes initial text displayed in display
            userIsInTheMiddleOfTyping = true
        }
    }
    
    var displayValue: Double {
        get {
            return Double(display.text!)!
        }
        set {
            display.text = String(newValue)
        }
    }

    private var brain = CalculatorBrain()
    
    @IBAction func performOperation(_ sender: UIButton) {
        if userIsInTheMiddleOfTyping {
            brain.setOperand(displayValue)
            userIsInTheMiddleOfTyping = false
            userHasTypedDecimal = false
        }
        if let mathematicalSymbol = sender.currentTitle {
            brain.performOperation(mathematicalSymbol)
        }
        if let result = brain.result {  //because result may not be set
            displayValue = result       //only display if result is set
        }
        sequence.text = brain.description
    }
}
