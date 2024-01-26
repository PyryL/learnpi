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
                KeyboardButton(manager: manager, key: .num(7))
                KeyboardButton(manager: manager, key: .num(8))
                KeyboardButton(manager: manager, key: .num(9))
            }
            HStack(spacing: 0) {
                KeyboardButton(manager: manager, key: .num(4))
                KeyboardButton(manager: manager, key: .num(5))
                KeyboardButton(manager: manager, key: .num(6))
            }
            HStack(spacing: 0) {
                KeyboardButton(manager: manager, key: .num(1))
                KeyboardButton(manager: manager, key: .num(2))
                KeyboardButton(manager: manager, key: .num(3))
            }
            HStack(spacing: 0) {
                KeyboardButton(manager: manager, key: nil)
                KeyboardButton(manager: manager, key: .num(0))
                KeyboardButton(manager: manager, key: .decimal)
            }
        }
        .padding(2)
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

fileprivate struct KeyboardButton: View {
    @ObservedObject var manager: Manager
    var key: KeyboardView.KeyboardKey?
    private let hapticFeedback = UIImpactFeedbackGenerator(style: .rigid)
    
    @State private var backgroundEffect: Color? = nil
    
    private func tapped() {
        guard let key else { return }
        let isCorrect = manager.typeDigit(key)
        
        if isCorrect {
            hapticFeedback.impactOccurred()
        }
        
        backgroundEffect = isCorrect ? Color(uiColor: .lightGray) : .red
    }
    
    private func tapEnded() {
        backgroundEffect = nil
    }
    
    var body: some View {
        Text(key?.label ?? "")
            .font(.system(size: 20, design: .monospaced))
            .frame(height: 70)
            .frame(maxWidth: .infinity)
            .background(backgroundEffect == nil ? Color(uiColor: .systemBackground) : backgroundEffect)
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(Color.primary, lineWidth: 2)
                .padding(1))
            .clipShape(RoundedRectangle(cornerRadius: 5))
            .padding(2)
            .opacity(key == nil ? 0 : 1)
            .animation(.easeInOut(duration: 0.04), value: backgroundEffect)
            .gesture(LongPressGesture(minimumDuration: .leastNonzeroMagnitude)
                .onChanged { value in
                    tapped()
                }
                .onEnded { value in
                    tapEnded()
                })
            .onAppear { hapticFeedback.prepare() }
    }
}

#Preview {
    KeyboardView(manager: Manager())
}
