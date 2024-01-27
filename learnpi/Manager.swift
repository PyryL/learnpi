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
    
    public func typeDigit(_ key: PiCharacter) -> Bool {
        guard let correctDigit = PiDigits.digit(digitOffset) else {
            return false
        }
        
        let isCorrect: Bool = key == correctDigit
        
        if isCorrect {
            digitOffset += 1
        }
        
        return isCorrect
    }
    
    public func restart() {
        digitOffset = 0
    }
}
