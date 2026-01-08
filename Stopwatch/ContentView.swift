import SwiftUI
import AVFoundation
import AppKit



struct ContentView: View {
    @State private var elapsedTime: TimeInterval = 0
    @State private var timer: Timer?
    @State private var isRunning = false
    @State private var currentSound: NSSound?


    var body: some View {
        VStack(spacing: 20) {
            Text(timeString(from: elapsedTime))
                .font(.system(size: 72, weight: .bold, design: .monospaced))

            HStack(spacing: 20) {
                Button("Start") {
                    start()
                }
                .disabled(isRunning)

                Button("Stop") {
                    stop()
                }
                .disabled(!isRunning)

                Button("Reset") {
                    reset()
                }
            }
            .buttonStyle(.borderedProminent)
        }
        .padding(40)
        .frame(minWidth: 300)
    }

    // MARK: - Actions

    private func start() {
        playSound(named: "start")
        isRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
            elapsedTime += 0.01
        }
    }

    private func stop() {
        playSound(named: "stop")
        isRunning = false
        timer?.invalidate()
        timer = nil
    }

    private func reset() {
        playSound(named: "reset")
        stop()
        elapsedTime = 0
    }

    // MARK: - Helpers

    private func timeString(from time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let hundredths = Int((time * 100).truncatingRemainder(dividingBy: 100))

        return String(format: "%02d:%02d.%02d", minutes, seconds, hundredths)
    }

    private func playSound(named name: String) {
        // Stop any sound already playing
        currentSound?.stop()

        // Create and play new sound
        if let sound = NSSound(named: NSSound.Name(name)) {
            sound.play()
            currentSound = sound
        }
    }

}
