//
//  DigitView.swift
//  learnpi
//
//  Created by Pyry Lahtinen on 25.1.2024.
//

import SwiftUI

struct DigitsView: View {
    @ObservedObject var manager: Manager
    @State private var showUpcomingDigits: Bool = false
    
    var isUpcomingDigitsShowAvailable: Bool {
        manager.mode == .practise || manager.isGameOver
    }
    
    var body: some View {
        HStack {
            ForEach(-3..<2) { offset in
                DigitView(manager: manager,
                          offset: offset,
                          showUpcomingDigits: showUpcomingDigits,
                          isUpcomingDigitsShowAvailable: isUpcomingDigitsShowAvailable)
            }
        }
        .background(Color.white.opacity(0.0001))
        .onTapGesture {
            if isUpcomingDigitsShowAvailable {
                showUpcomingDigits.toggle()
            }
        }
        .onChange(of: manager.mode) {
            if manager.mode != .practise {
                showUpcomingDigits = false
            }
        }
        .padding([.horizontal, .top])
    }
}

fileprivate struct DigitView: View {
    @ObservedObject var manager: Manager
    var offset: Int
    var showUpcomingDigits: Bool
    var isUpcomingDigitsShowAvailable: Bool
    
    private var digit: String {
        if manager.digitOffset+offset == -2 { return "π" }
        if manager.digitOffset+offset == -1 { return "≈" }
        
        guard let digit = PiDigits.digit(manager.digitOffset+offset) else {
            return "-"
        }
        
        switch digit {
        case .digit(let value):
            return "\(value)"
        case .decimal:
            return "."
        }
    }
    
    private var opacity: CGFloat {
        if digit == "-" {
            return 0
        } else if offset == -1 {
            return 1
        } else if !showUpcomingDigits, offset >= 0 {
            return 0
        }
        return 0.5
    }
    
    var body: some View {
        Text(digit)
            .font(.system(size: CGFloat(40-5*abs(offset+1)), design: .monospaced))
            .frame(maxWidth: .infinity)
            .opacity(opacity)
            .overlay(overlayIcon)
    }
    
    @ViewBuilder private var overlayIcon: some View {
        if !showUpcomingDigits, offset == 0, isUpcomingDigitsShowAvailable {
            Image(systemName: "eye.slash")
                .font(.system(size: 20))
                .foregroundStyle(.tertiary)
                .offset(x: 30, y: 0)
        }
    }
}

#Preview {
    DigitsView(manager: Manager())
}
