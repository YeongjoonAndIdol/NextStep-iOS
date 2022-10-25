//
//  WriteRetrospectsRequestDTO.swift
//  Next-Stap
public struct WriteRetrospectsRequestDTO: Encodable {
    public let content: String

    public init(content: String) {
        self.content = content
    }
}
