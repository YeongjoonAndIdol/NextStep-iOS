import Foundation

struct FetchQuestListResponseDTO: Codable {
    let quest: [SingleQuestDTO]
    let progress: Int
}

struct SingleQuestDTO: Codable {
    let id: String
    let name: String
    let isCompleted: Bool

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case isCompleted = "is_complete"
    }
}
