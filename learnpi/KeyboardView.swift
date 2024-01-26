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
    
    @GestureState private var tapStatus: Bool = false
    @State private var isCorrectTap: Bool = true
    
    private func tapped() {
        guard let key else { return }
        isCorrectTap = manager.typeDigit(key)
        
        if isCorrectTap {
            hapticFeedback.impactOccurred()
        }
    }
    
    var body: some View {
        Text(key?.label ?? "")
            .font(.system(size: 20, design: .monospaced))
            .frame(height: 70)
            .frame(maxWidth: .infinity)
            .background(!tapStatus ? Color(uiColor: .systemBackground) : isCorrectTap ? Color(uiColor: .lightGray) : Color.red)
            .overlay(RoundedRectangle(cornerRadius: 5)
                .stroke(Color.primary, lineWidth: 2)
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
