//
//  ContentView.swift
//  egg-timer
//
//  Created by Leonid on 31.01.2021.
//

import SwiftUI


struct ContentView: View {
    @State private var currentProgress = 0.0
    @State private var totalProgress: Double = 100

//    @State private var newTimer = Date()
    @State private var isTimerRunning = false
    @State private var timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    let eggsTimer = [100, 200, 300]
    
    func stopTimer() {
        self.timer.upstream.connect().cancel()
        currentProgress = 0
//        isTimerRunning = false
    }
    
    func startTimer() {
//        isTimerRunning = true
        self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    }
    
    func finish() {
        if currentProgress < totalProgress {
            currentProgress += 50
        } else {
            stopTimer()
        }
    }
    
    var body: some View {
        VStack {
            ForEach(0..<3) { item in
                Button(action: {
//                    stopTimer()
                    currentProgress = 0
                    
                    if isTimerRunning {
                        stopTimer()
                    } else {
//                        newTimer = Date()
                        startTimer()
                    }
                    
                    isTimerRunning.toggle()
                    totalProgress = Double(eggsTimer[item])
              }) {
                    Text(isTimerRunning ? "Stop \(item)" : "Start \(item)")
                        .padding()
                }
            }

            ProgressView("Progress: \(currentProgress, specifier: "%.f") / \(totalProgress, specifier: "%.f")", value: currentProgress, total: totalProgress)
                    .padding()
        }
        .onAppear() {
            stopTimer()
        }
        .onReceive(timer) { time in
            finish()
            
        }
    }
    
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
