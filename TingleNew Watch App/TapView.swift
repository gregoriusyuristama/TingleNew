//
//  TapView.swift
//  Tingle Watch App
//
//  Created by Azella Mutyara on 24/08/23.
//

import SwiftUI

struct TapView: View {
    @State private var rectangleSize: CGSize = CGSize(width: 50, height: 50)
    @State private var isTimerRunning = false
    
    private var arrImagesName = [
        "Emoji1",
        "Emoji2",
        "Emoji3",
        "Emoji4",
        "Emoji5",
        "Emoji6",
        "Emoji7",
        "Emoji8",
        "Emoji9",
        "Emoji10",
    ]
    @State private var counter: Int = 0
    
    var body: some View {
        
        Image(arrImagesName[counter])
            .resizable()
            .frame(width: rectangleSize.width, height: rectangleSize.height)
            .foregroundColor(Color.blue)
            .onAppear {
                startTimer()
            }
            .onTapGesture {
                //                resetTimer()
                withAnimation {
                    playHapticPattern()
                    guard counter + 2 < 10 else { return }
                    counter += 2
                    rectangleSize = CGSize(width: rectangleSize.width + 20, height: rectangleSize.height + 20)
                }
            }
    }
    
    func playHapticPattern() {
        let hapticTypes: [WKHapticType] = [.click, .directionUp, .directionDown]
        
        for hapticType in hapticTypes {
            WKInterfaceDevice.current().play(hapticType)
            // Pause briefly between haptic types to simulate a pattern
            Thread.sleep(forTimeInterval: 0.01)
        }
    }
    
    func startTimer() {
        guard !isTimerRunning else { return }
        Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { timer in
            if rectangleSize.width > 50 {
                withAnimation {
                    guard counter - 1 > 0 else { return }
                    counter -= 1
                    rectangleSize = CGSize(width: rectangleSize.width - 10, height: rectangleSize.height - 10)
                    playHapticPattern()
                }
            }
        }
        isTimerRunning = true
    }
    
    func resetTimer() {
        isTimerRunning = false
    }
}

struct TapView_Previews: PreviewProvider {
    static var previews: some View {
        TapView()
    }
}
