import Foundation

public struct AddQuestRequestDTO: Encodable {
    public let title: String
    public let period: String
    public let time: String
    public let content: String
    public let schoolType: String

    public init(
        title: String,
        period: String,
        time: String,
        content: String,
        schoolType: String
    ) {
        self.title = title
        self.period = period
        self.time = time
        self.content = content
        self.schoolType = schoolType
    }

    enum CodingKeys: String, CodingKey {
        case title
        case period
        case time
        case content
        case schoolType = "school_type"
    }
}
