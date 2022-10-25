import Foundation

public struct SIgnUpRequestDTO: Encodable {
    public let id: String
    public let password: String
    public let name: String

    public init(accountID: String, password: String, name: String) {
        self.id = accountID
        self.password = password
        self.name = name
    }
}
