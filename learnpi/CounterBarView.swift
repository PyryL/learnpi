//
//  CounterBarView.swift
//  learnpi
//
//  Created by Pyry Lahtinen on 25.1.2024.
//

import SwiftUI

struct CounterBarView: View {
    @ObservedObject var manager: Manager
    
    var body: some View {
        HStack {
            Text("Digit: \(manager.digitCount)")
            Spacer()
            // TODO: timer
        }
        .padding(.horizontal)
    }
}

#Preview {
    CounterBarView(manager: Manager())
}
