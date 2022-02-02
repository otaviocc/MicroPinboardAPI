import Foundation

extension DateFormatter {

    static let defaultAPIFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYY-MM-DD"
        dateFormatter.locale = NSLocale.current
        return dateFormatter
    }()
}
