//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by newtan on 2021-01-28.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @State private var scrums = DailyScrum.data
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $scrums)
            }
        }
    }
}
