import Foundation

public struct SuggestResponse: Decodable {
    public let popular: [String]
    public let recommended: [String]
}
