/*
See LICENSE folder for this sample’s licensing information.
*/

import Foundation

// Codable is a type alias that combines the Encodable and Decodable protocols. When you implement these protocols on your types, you can use the Codable API to easily serialize data to and from JSON.
struct History: Identifiable, Codable {
    let id: UUID
    let date: Date
    var attendees: [String]
    var lengthInMinutes: Int
    var transcript: String?

    init(id: UUID = UUID(), date: Date = Date(), attendees: [String], lengthInMinutes: Int, transcript: String? = nil) {
        self.id = id
        self.date = date
        self.attendees = attendees
        self.lengthInMinutes = lengthInMinutes
        self.transcript = transcript
    }
}
