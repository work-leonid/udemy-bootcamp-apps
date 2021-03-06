//
//  SwiftUIView.swift
//  egg-timer
//
//  Created by Leonid on 31.01.2021.
//

import SwiftUI

struct TimerView: View {
    @State var isTimerRunning = false
    @State private var startTime =  Date()
    @State private var timerString = "0.00"
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()

    var body: some View {

        VStack {
            Button(action: {
                stopTimer()
                timerString = "0.00"
            }) {
                Text("Reset")
            }
            Text(self.timerString)
                .font(Font.system(.largeTitle, design: .monospaced))
                .onReceive(timer) { _ in
                    if self.isTimerRunning {
                        timerString = String(format: "%.2f", (Date().timeIntervalSince( self.startTime)))
                    }
                }
                .onTapGesture {
                    if isTimerRunning {
                        // stop UI updates
                        self.stopTimer()
                    } else {
                        timerString = "0.00"
                        startTime = Date()
                        // start UI updates
                        self.startTimer()
                    }
                    isTimerRunning.toggle()
                }
                .onAppear() {
                    // no need for UI updates at startup
                    self.stopTimer()
                }
        }
        
    }
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
    }
    
    func startTimer() {
        self.timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView()
    }
}
