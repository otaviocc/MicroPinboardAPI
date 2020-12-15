import Foundation

public struct DatesResponse: Decodable {
    public let user: String
    public let tag: String
    public let dates: [String: Int]
}
