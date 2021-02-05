//
//  ScrumdingerApp.swift
//  Scrumdinger
//
//  Created by newtan on 2021-01-28.
//

import SwiftUI

@main
struct ScrumdingerApp: App {
    @ObservedObject private var data = ScrumData()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                ScrumsView(scrums: $data.scrums) {
                    data.save()
                }
            }
            .onAppear {
                // Load the user’s scrums when the app’s root NavigationView appears on screen.
                data.load()
            }
        }
    }
}
