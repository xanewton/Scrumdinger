//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by newtan on 2021-01-28.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: DailyScrum.data)
            }
        }
    }
}
