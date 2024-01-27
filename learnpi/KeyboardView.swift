//
//  KeyboardView.swift
//  learnpi
//
//  Created by Pyry Lahtinen on 25.1.2024.
//

import SwiftUI

struct KeyboardView: View {
    @ObservedObject var manager: Manager
    
    var body: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                KeyboardButton(manager: manager, key: .digit(7))
                KeyboardButton(manager: manager, key: .digit(8))
                KeyboardButton(manager: manager, key: .digit(9))
            }
            HStack(spacing: 0) {
                KeyboardButton(manager: manager, key: .digit(4))
                KeyboardButton(manager: manager, key: .digit(5))
                KeyboardButton(manager: manager, key: .digit(6))
            }
            HStack(spacing: 0) {
                KeyboardButton(manager: manager, key: .digit(1))
                KeyboardButton(manager: manager, key: .digit(2))
                KeyboardButton(manager: manager, key: .digit(3))
            }
            HStack(spacing: 0) {
                KeyboardButton(manager: manager, key: nil)
                KeyboardButton(manager: manager, key: .digit(0))
                KeyboardButton(manager: manager, key: .decimal)
            }
        }
        .padding(2)
    }
}

fileprivate struct KeyboardButton: View {
    @ObservedObject var manager: Manager
    var key: PiCharacter?
    private let hapticFeedback = UIImpactFeedbackGenerator(style: .rigid)
    
    @GestureState private var tapStatus: Bool = false
    @State private var isCorrectTap: Bool = true
    
    private func tapped() {
        guard let key else { return }
        isCorrectTap = manager.typeDigit(key)
        
        if isCorrectTap {
            hapticFeedback.impactOccurred()
        }
    }
    
    private var label: String {
        switch key {
        case .digit(let value):
            return "\(value)"
        case .decimal:
            return "."
        case nil:
            return ""
        }
    }
    
    private var background: Color {
        if manager.isGameOver {
            return Color.red
        }
        if !tapStatus {
            return Color(uiColor: .systemBackground)
        }
        if isCorrectTap {
            return Color(uiColor: .systemGray3)
        }
        return Color.red
    }
    
    var body: some View {
        Text(label)
            .font(.system(size: 20, design: .monospaced))
            .frame(height: 70)
            .frame(maxWidth: .infinity)
            .background(background)
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(Color.accentColor, lineWidth: 2)
                .padding(1))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(2)
            .opacity(key == nil ? 0 : 1)
            .gesture(LongPressGesture(minimumDuration: .leastNonzeroMagnitude)
                .updating($tapStatus) { value, state, transaction in
                    state = value
                    if value {
                        DispatchQueue.main.async {
                            tapped()
                        }
                    }
                })
            .onAppear { hapticFeedback.prepare() }
    }
}

#Preview {
    KeyboardView(manager: Manager())
}
