//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by newtan on 2021-01-30.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    // SwiftUI indicates the current operational state of your app’s Scene instances with a scenePhase Environment value.
    @Environment(\.scenePhase) private var scenePhase
    @State private var isPresented = false
    @State private var newScrumData = DailyScrum.Data()
    let saveAction: () -> Void
    
    var body: some View {
        List {
            ForEach(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: binding(for: scrum))) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.color)
            }
        }
        // Navigation modifiers, such as title and bar items, are added to child views and propagated to the parent NavigationView.
        .navigationTitle("Daily Scrums")
        .navigationBarItems(trailing: Button(action: {
            isPresented = true
        }) {
            Image(systemName: "plus")
        })
        // A sheet presents a view similar to fullScreenCover, but it provides context by leaving the underlying view partially visible.
        .sheet(isPresented: $isPresented) {
            NavigationView {
                EditView(scrumData: $newScrumData)
                    .navigationBarItems(leading: Button("Dismiss") {
                        isPresented = false
                    }, trailing: Button("Add") {
                        let newScrum = DailyScrum(title: newScrumData.title, attendees: newScrumData.attendees, lengthInMinutes: Int(newScrumData.lengthInMinutes), color: newScrumData.color)
                        // The scrums array is a binding, so updating the array in this view updates the source of truth contained in the app.
                        scrums.append(newScrum)
                        isPresented = false
                    })
            }
        }
        .onChange(of: scenePhase) { phase in
            // A scene in the inactive phase no longer receives events and may be unavailable to the user.
            // Tip
            // Refer to ScenePhase for descriptions of each phase and instructions for triggering actions when the phase changes.
            // https://developer.apple.com/documentation/swiftui/scenephase
            if phase == .inactive { saveAction() }
        }
    }
    
    private func binding(for scrum: DailyScrum) -> Binding<DailyScrum> {
        guard let scrumIndex = scrums.firstIndex(where: { $0.id == scrum.id }) else {
            fatalError("Can't find scrum in array")
        }
        return $scrums[scrumIndex]
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        // Adding the NavigationView displays navigation elements, like title and bar buttons, on the canvas.
        NavigationView {
            ScrumsView(scrums: .constant(DailyScrum.data), saveAction: {})
        }
    }
}
