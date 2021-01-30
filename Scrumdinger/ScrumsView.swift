//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by newtan on 2021-01-30.
//

import SwiftUI

struct ScrumsView: View {
    let scrums: [DailyScrum]
    
    var body: some View {
        List {
            ForEach(scrums) { scrum in
                NavigationLink(destination: DetailView(scrum: scrum)) {
                    CardView(scrum: scrum)
                }
                .listRowBackground(scrum.color)
            }
        }
        .navigationTitle("Daily Scrums")
        .navigationBarItems(trailing: Button(action: {}) {
            Image(systemName: "plus")
        })
    }
}

struct ScrumsView_Previews: PreviewProvider {
    static var previews: some View {
        // Adding the NavigationView displays navigation elements, like title and bar buttons, on the canvas.
        NavigationView {
            ScrumsView(scrums: DailyScrum.data)
        }
    }
}
