import Foundation

public struct AddListRequestDTO: Encodable {
    public let title: String
    public let content: String
    public let type: String

    public init(
        title: String,
        content: String,
        type: String
    ) {
        self.title = title
        self.content = content
        self.type = type
    }
}
