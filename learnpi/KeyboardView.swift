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
    KeyboardView(manager: Manager())
}
