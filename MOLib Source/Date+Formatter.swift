import Foundation

extension Formatter {
    static let iso8601: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = .current
        formatter.timeZone = TimeZone(secondsFromGMT: 0)
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSXXXXX"
        return formatter
        
    }()
    
    static let niceFormat: DateFormatter = {
        
        let formatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .iso8601)
        formatter.locale = .current
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter
        
    }()
    
}

extension Date {
    
    var iso8601: String {
        
        return Formatter.iso8601.string(from: self)
        
    }
    
    var niceFormat: String {
        
        return Formatter.niceFormat.string(from: self)
        
    }
    
}

extension String {
    
    var dateFromISO8601: Date? {
        
        return Formatter.iso8601.date(from: self)   // "Mar 22, 2017, 10:22 AM"
        
    }
    
    var niceFormat: Date? {
        
        return Formatter.niceFormat.date(from: self)
        
    }
    
}
