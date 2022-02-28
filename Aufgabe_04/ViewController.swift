//  Prüfungsarbeit PR_179_01
//  ViewController.swift
//  Programmieraufgaben Apps mit grafischer Oberfläche
//  Aufgabe_04
//
//  Created by Zoltán Gál on 2021. 01. 09..
//  Copyright © 2021. Zoltán Gál. All rights reserved.
//

import Cocoa

class ViewController: NSViewController {

    @IBOutlet weak var eingabeZahl: NSTextField!
    @IBOutlet weak var labelErgebnis: NSTextField!
    
    @IBOutlet weak var opDualDezimal: NSButton!
    @IBOutlet weak var opDezimalDual: NSButton!
    @IBOutlet weak var opRoemischArabisch: NSButton!
    @IBOutlet weak var opArabischRoemisch: NSButton!
    
    
    func dualDezimal(){
        let zahl = eingabeZahl.stringValue
        if let nummer = Int(zahl, radix: 2){
            labelErgebnis.integerValue = nummer
            labelErgebnis.sizeToFit()
        }
    }
    
    func dezimalDual(){
        let zahl = eingabeZahl.integerValue
        let nummer = String(zahl, radix: 2)
            labelErgebnis.stringValue = nummer
            labelErgebnis.sizeToFit()
    }
    
    func arabischRoemisch(nummer: Int) -> String{
        let dezimalen = [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
        let nummern = ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]

        var result = ""
        var nummer = nummer

        while nummer > 0
            {
            for (index, dezimal) in dezimalen.enumerated()
                {
                if nummer - dezimal >= 0 {
                    nummer = nummer - dezimal
                    result += nummern[index]
                    break
                    }
                }
            }
        return result
    }
    
    func getValue(char: Character) -> Int{
        var charWert = 0
        if char == "I"{ charWert = 1}
        if char == "V"{ charWert = 5}
        if char == "X"{ charWert = 10}
        if char == "L"{ charWert = 50}
        if char == "C"{ charWert = 100}
        if char == "D"{ charWert = 500}
        if char == "M"{ charWert = 1000}
        return charWert
    }
    
    func roemischArabisch(s: String) -> Int{
    var result = 0
    let romanArray = Array(s)
        //print(romanArray)
    var index = 0
        while index < s.count {
            let char = romanArray[index]
            let characterWert = getValue(char: char)
            
            if index == s.count - 1 {
               result += characterWert
            }
            else{
                let naechsteChar = romanArray[index+1]
                let naechsteCharWert = getValue(char: naechsteChar)
               
                if characterWert < naechsteCharWert {
                    result += naechsteCharWert - characterWert
                    index += 1
                }else {
                    result += characterWert
                }
            }
            index += 1
        }
        return result
    }
    
    @IBAction func funcUmrechnen(_ sender: Any) {
        if opDualDezimal.state == NSControl.StateValue.on{
            dualDezimal()
        }
        if opDezimalDual.state == NSControl.StateValue.on{
            dezimalDual()
        }
        if opArabischRoemisch.state == NSControl.StateValue.on {
            labelErgebnis.stringValue = arabischRoemisch(nummer: eingabeZahl!.integerValue)
            labelErgebnis.sizeToFit()
        }
        if opRoemischArabisch.state == NSControl.StateValue.on {
            labelErgebnis.integerValue = roemischArabisch(s: eingabeZahl.stringValue)
            labelErgebnis.sizeToFit()
            
        }
    }
    
    
    @IBAction func funcBeenden(_ sender: Any) {
        NSApplication.shared.terminate(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
}

