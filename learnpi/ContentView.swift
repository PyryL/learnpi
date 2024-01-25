//
//  ContentView.swift
//  learnpi
//
//  Created by Pyry Lahtinen on 25.1.2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var manager = Manager()
    
    var body: some View {
        NavigationStack {
            VStack {
                DigitView(manager: manager)
                Spacer()
                KeyboardView(manager: manager)
            }
            .background(Color(uiColor: .secondarySystemBackground))
            .navigationTitle("Learn π")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

class Manager: ObservableObject {
    @Published private(set) var digitOffset: Int = 0
    
    public func typeDigit(_ key: KeyboardView.KeyboardKey) {
        guard digitOffset < PiDigits.digits.endIndex else { return }
        
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
    }
}

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

struct KeyboardView: View {
    @ObservedObject var manager: Manager
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                keyView(key: .num(7))
                keyView(key: .num(8))
                keyView(key: .num(9))
            }
            HStack(spacing: 0) {
                keyView(key: .num(4))
                keyView(key: .num(5))
                keyView(key: .num(6))
            }
            HStack(spacing: 0) {
                keyView(key: .num(1))
                keyView(key: .num(2))
                keyView(key: .num(3))
            }
            HStack(spacing: 0) {
                keyView(key: nil)
                keyView(key: .num(0))
                keyView(key: .decimal)
            }
        }
    }
    
    @ViewBuilder private func keyView(key: KeyboardKey?) -> some View {
        Button(action: {
            guard let key else { return }
            manager.typeDigit(key)
        }) {
            Text(key?.label ?? "")
                .font(.system(size: 20, design: .monospaced))
                .frame(height: 70)
                .frame(maxWidth: .infinity)
                .background(Color(uiColor: .systemBackground))
                .overlay(RoundedRectangle(cornerRadius: 5)
                    .stroke(Color.primary, lineWidth: 2)
                    .padding(1))
                .clipShape(RoundedRectangle(cornerRadius: 5))
        }
        .buttonStyle(.plain)
        .padding(2)
        .opacity(key == nil ? 0 : 1)
    }
    
    enum KeyboardKey {
        case num(Int), decimal
        
        var label: String {
            switch self {
            case .num(let value):
                return "\(value)"
            case .decimal:
                return "."
            }
        }
    }
}

#Preview {
    ContentView()
}
