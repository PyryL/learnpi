//
//  DurationFormatter.swift
//  learnpi
//
//  Created by Pyry Lahtinen on 27.1.2024.
//

import Foundation

class DurationFormatter {
    static func format(_ duration: TimeInterval) -> String {
        let duration = round(duration * 10) / 10
        let minutes = Int((duration/60).truncatingRemainder(dividingBy: 60))
        let seconds = Int(duration.truncatingRemainder(dividingBy: 60))
        let fraction = Int((duration*10).truncatingRemainder(dividingBy: 10))
        
        var result = ""
        
        if minutes > 0 {
            result += "\(minutes):"
            result += String(format: "%02d", seconds)
        } else {
            result += "\(seconds)"
        }
        
        result += ".\(fraction)"
        
        return result
    }
}
