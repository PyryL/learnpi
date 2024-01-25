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

#Preview {
    ContentView()
}
