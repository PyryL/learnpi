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
                DigitsView(manager: manager)
                Spacer()
                CounterBarView(manager: manager)
                KeyboardView(manager: manager)
            }
            .background(Color(uiColor: .secondarySystemBackground))
            .navigationTitle("Learn π")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button(action: manager.restart) {
                        Label("Restart", systemImage: "arrow.counterclockwise")
                    }
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
