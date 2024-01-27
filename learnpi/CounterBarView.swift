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
            Label("\(manager.digitCount)", systemImage: "number.circle")
            Spacer()
            TimerView(manager: manager)
        }
        .padding(.horizontal)
    }
}

fileprivate struct TimerView: View {
    @ObservedObject var manager: Manager
    @State var formattedDuration: String = ""
    
    private func calculateLabel() {
        let startDate = manager.startDate ?? .now
        let duration = -startDate.timeIntervalSinceNow
        formattedDuration = DurationFormatter.format(duration)
    }
    
    var body: some View {
        Label(formattedDuration, systemImage: "timer.circle")
            .onChange(of: manager.digitOffset) { calculateLabel() }
            .onChange(of: manager.startDate) { calculateLabel() }
            .onTapGesture { calculateLabel() }
            .onAppear(perform: calculateLabel)
    }
}

#Preview {
    CounterBarView(manager: Manager())
}
