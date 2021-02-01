//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by newtan on 2021-01-30.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    
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
        .navigationBarItems(trailing: Button(action: {}) {
            Image(systemName: "plus")
        })
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
            ScrumsView(scrums: .constant(DailyScrum.data))
        }
    }
}
