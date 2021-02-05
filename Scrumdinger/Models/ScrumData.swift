//
//  ScrumData.swift
//  Scrumdinger
//
//  Created by newtan on 2021-02-04.
//

import Foundation

// ObservableObject is a class-constrained protocol for connecting external model data to SwiftUI views.
class ScrumData: ObservableObject {
    
    private static var documentsFolder: URL {
        do {
            return try FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false)
        } catch {
            fatalError("Can't find documents directory.")
        }
    }
    
    private static var fileURL: URL {
        return documentsFolder.appendingPathComponent("scrums.data")
    }
    
    // An ObservableObject includes an objectWillChange publisher that emits when one of its @Published properties is about to change. Any view observing an instance of ScrumData will re-render when the scrums value changes.
    @Published var scrums: [DailyScrum] = []
}
