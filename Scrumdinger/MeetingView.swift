//
//  ContentView.swift
//  Scrumdinger
//
//  Created by newtan on 2021-01-28.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    // You can use @StateObject to create a source of truth for reference type models that conform to the ObservableObject protocol.
    // Wrapping a reference type property as a @StateObject keeps the object alive for the life cycle of a view.
    @StateObject var scrumTimer = ScrumTimer()
    @State private var transcript = ""
    @State private var isRecording = false
    // Scrumdinger uses the microphone to record the audio that is used to generate the meeting transcripts. As a security feature, users must explicitly grant access to personal information or sensitive device hardware. For guidelines to secure user data, see Protecting the User’s Privacy. https://developer.apple.com/documentation/uikit/protecting_the_user_s_privacy
    private let speechRecognizer = SpeechRecognizer()
    var player: AVPlayer { AVPlayer.sharedDingPlayer }
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.color)
            VStack {
                // SwiftUI supports composing large views from smaller views.
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, scrumColor: scrum.color)
                MeetingTimerView(speakers: scrumTimer.speakers, isRecording: isRecording, scrumColor: scrum.color)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.color.accessibleFontColor)
        
        // SwiftUI provides life cycle methods to trigger events when a view appears and disappears. For example, you could add onAppear(perform:) to start an animation after a view appears. And you could add onDisappear(perform:) to release unnecessary resources when a view disappears.
        .onAppear {
            // The timer resets each time an instance of MeetingView shows on screen, indicating that a meeting should begin.
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                player.seek(to: .zero)
                player.play()
            }
            speechRecognizer.record(to: $transcript)
            isRecording = true
            scrumTimer.startScrum()
        }
        .onDisappear {
            scrumTimer.stopScrum()
            isRecording = false
            speechRecognizer.stopRecording()
            let newHistory = History(attendees: scrum.attendees, lengthInMinutes: scrumTimer.secondsElapsed / 60)
            scrum.history.insert(newHistory, at: 0)
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.data[0]))
    }
}
