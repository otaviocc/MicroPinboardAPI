import Foundation

public struct RecentResponse: Decodable {
    public let date: Date
    public let user: String
    public let posts: [PostResponse]
}
