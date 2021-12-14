import UIKit

var greeting = "Hello, playground"

let current = Date()

extension Date {
    var yyyyMMddHHmm: String {
        let format = DateFormatter()
        format.dateFormat = "yyyy-MM-dd HH:mm"
        return format.string(from: self)
    }

    var isToday: Bool {
        let calendar = Calendar(identifier: .gregorian)
        
        return calendar.isDateInToday(self)
    }

    // 数時間後
    var afterSeveralHours: Date {
        let calendar = Calendar(identifier: .gregorian)
        let day = calendar.date(
            byAdding: .hour,
            value: 15,
            to: self)
        return day!
    }
}

print(current.yyyyMMddHHmm)
print(current.afterSeveralHours.yyyyMMddHHmm)
print(current.afterSeveralHours.isToday)
