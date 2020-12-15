import Foundation

public struct PostResponse: Decodable, Identifiable {
    public var id = UUID()
    public let href: String
    public let description: String
    public let extended: String
    public let meta: String
    public let hash: String
    public let time: Date
    public let shared: String
    public let toread: String
    public let tags: String
}
