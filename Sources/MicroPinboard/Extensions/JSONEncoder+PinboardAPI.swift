import Foundation

extension JSONEncoder {

    static let defaultJSONEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .formatted(.defaultAPIFormatter)
        return encoder
    }()
}
