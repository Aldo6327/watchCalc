//
//  InterfaceController.swift
//  wristCalc WatchKit Extension
//
//  Created by Aldo Ayala on 7/31/18.
//  Copyright © 2018 Aldo Ayala. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    enum modes {
        case NOT_SET
        case ADDITION
        case SUBTRACTION
        case Multiply
        case Divide
        case Percentage
    }
    
    var labelString:String = "0"
    
    var currentMode:modes = modes.NOT_SET
    var savedNum:Int = 0
    var lastButtonMode:Bool = false
    
    @IBOutlet var userScreen: WKInterfaceLabel!
    @IBAction func tapped0(){tappedNumber(num: 0)}
    @IBAction func tapped1(){tappedNumber(num: 1)}
    @IBAction func tapped2(){tappedNumber(num: 2)}
    @IBAction func tapped3(){tappedNumber(num: 3)}
    @IBAction func tapped4(){tappedNumber(num: 4)}
    @IBAction func tapped5(){tappedNumber(num: 5)}
    @IBAction func tapped6(){tappedNumber(num: 6)}
    @IBAction func tapped7(){tappedNumber(num: 7)}
    @IBAction func tapped8(){tappedNumber(num: 8)}
    @IBAction func tapped9(){tappedNumber(num: 9)}

    func tappedNumber (num: Int){
        if lastButtonMode {
            lastButtonMode = false
            labelString = "0"
        }
        labelString = labelString.appending("\(num)")
        updateText()
    }

    func updateText() {
        guard let labelInt:Int64 = Int64(labelString) else {
            userScreen.setText("Number is too Large")
            return
        }
        savedNum = (currentMode == modes.NOT_SET) ? (Int(labelInt)) : savedNum
        
        let formatter:NumberFormatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        let nsInt: NSNumber = NSNumber(value: labelInt)
        let str:String = formatter.string(from: nsInt)!

        userScreen.setText(str)
        
    }


    func changeMode(newMode: modes) {
        if savedNum == 0 {
            return
        }
       currentMode = newMode
        lastButtonMode = true
    }
    
    @IBAction func plusSelected() {
        changeMode(newMode: modes.ADDITION)
    }
    
    @IBAction func minusSelected() {
        changeMode(newMode: modes.SUBTRACTION)
    }
    
    @IBAction func multiplySelected() {
        changeMode(newMode: modes.Multiply)
    }
    
    @IBAction func divideSelected() {
        changeMode(newMode: modes.Divide)
    }
    @IBAction func clearSelected() {
        savedNum = 0
        labelString = "0"
        userScreen.setText("0")
        currentMode = modes.NOT_SET
        lastButtonMode = false
        
    }
    @IBAction func percentSelected() {
        changeMode(newMode: modes.Percentage)
        print("% selected")
    }
    @IBAction func equalsSelected() {
        guard let num:Int = Int(labelString) else {
            return
        }
        if currentMode == modes.NOT_SET || lastButtonMode {
            return
        }
        if currentMode == modes.ADDITION {
            savedNum += num
            
        }
        if currentMode == modes.SUBTRACTION {
            savedNum -= num
        }
        if currentMode == modes.Multiply {
            savedNum *= num
        }
        if currentMode == modes.Divide {
            savedNum /= num
        }
        if currentMode == modes.Percentage {
            
        }
        currentMode = modes.NOT_SET
        labelString = "\(savedNum)"
        updateText()
        lastButtonMode = true
    }

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
