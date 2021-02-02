//
//  ContentView.swift
//  Scrumdinger
//
//  Created by newtan on 2021-01-28.
//

import SwiftUI

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    // You can use @StateObject to create a source of truth for reference type models that conform to the ObservableObject protocol.
    @StateObject var scrumTimer = ScrumTimer()
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16.0)
                .fill(scrum.color)
            VStack {
                // SwiftUI supports composing large views from smaller views.
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, scrumColor: scrum.color)
                Circle()
                    .strokeBorder(lineWidth: 24, antialiased: true)
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
            }
        }
        .padding()
        .foregroundColor(scrum.color.accessibleFontColor)
        
        // SwiftUI provides life cycle methods to trigger events when a view appears and disappears. For example, you could add onAppear(perform:) to start an animation after a view appears. And you could add onDisappear(perform:) to release unnecessary resources when a view disappears.
        .onAppear {
            // The timer resets each time an instance of MeetingView shows on screen, indicating that a meeting should begin.
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.startScrum()
        }
        .onDisappear {
            scrumTimer.stopScrum()
        }
    }
}

struct MeetingView_Previews: PreviewProvider {
    static var previews: some View {
        MeetingView(scrum: .constant(DailyScrum.data[0]))
    }
}
