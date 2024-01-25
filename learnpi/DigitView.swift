//
//  DigitView.swift
//  learnpi
//
//  Created by Pyry Lahtinen on 25.1.2024.
//

import SwiftUI

struct DigitView: View {
    @ObservedObject var manager: Manager
    
    private func getDigit(offset: Int) -> String {
        guard manager.digitOffset+offset >= 0,
              manager.digitOffset+offset < PiDigits.digits.endIndex else { return "-" }
        let digit = PiDigits.digits[manager.digitOffset+offset]
        if digit == -1 { return "." }
        return "\(digit)"
    }
    
    var body: some View {
        HStack {
            digitView(offset: -3)
            digitView(offset: -2)
            digitView(offset: -1)
            digitView(offset: 0)
            digitView(offset: 1)
        }
        .padding([.horizontal, .top])
    }
    
    @ViewBuilder private func digitView(offset: Int) -> some View {
        Text("\(getDigit(offset: offset))")
            .font(.system(size: CGFloat(40-5*abs(offset+1)), design: .monospaced))
            .frame(maxWidth: .infinity)
            .opacity(getDigit(offset: offset) == "-" ? 0 : offset == -1 ? 1 : 0.5)
    }
}

#Preview {
    DigitView(manager: Manager())
}
