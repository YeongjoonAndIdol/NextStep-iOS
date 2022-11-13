import Foundation

public struct SigninRequestDTO: Encodable {
    public let id: String
    public let password: String

    public init(accountID: String, password: String) {
        self.id = accountID
        self.password = password
    }
    enum CodingKeys: String, CodingKey {
        case id = "accountId"
        case password
    }
}
