//
//  Manager.swift
//  learnpi
//
//  Created by Pyry Lahtinen on 25.1.2024.
//

import Foundation

class Manager: ObservableObject {
    @Published private(set) var digitOffset: Int = 0
    
    public var digitCount: Int {
        if digitOffset < 2 {
            return digitOffset
        }
        return digitOffset - 1
    }
    
    public func typeDigit(_ key: KeyboardView.KeyboardKey) -> Bool {
        guard digitOffset < PiDigits.digits.endIndex else { return false }
        
        let correctDigit = PiDigits.digits[digitOffset]
        let isCorrect: Bool
        switch key {
        case .num(let value):
            isCorrect = value == correctDigit
        case .decimal:
            isCorrect = correctDigit == -1
        }
        
        if isCorrect {
            digitOffset += 1
        }
        
        return isCorrect
    }
}
