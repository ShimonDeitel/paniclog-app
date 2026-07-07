import Foundation

struct EpisodeEntry: Identifiable, Codable, Equatable {
    var id: UUID = UUID()
    var date: Date = Date()
    var title: String
    var metric: Int          // Intensity
    var tag: String          // Coping method
    var note: String = ""
}

enum PanicLogTags {
    static let all: [String] = ["Breathing", "Grounding", "Walked away", "Called someone", "None"]
}
