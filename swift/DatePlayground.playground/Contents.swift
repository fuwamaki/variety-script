//: Playground - noun: a place where people can play

import UIKit

// ---old style---

let now = Date.now

var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    return dateFormatter
}()

print(dateFormatter.string(from: now))

if let value = dateFormatter.date(from: "2021-02-11") {
    print(value)
}


// ---


// MARK: formatted
print("formattedの確認")
print(now.formatted())                                      // 6/28/2021, 2:48 PM
print(now.formatted(.dateTime))                             // 6/28/2021, 2:48 PM
print(now.formatted(.dateTime.locale(Locale(identifier: "ja_JP")))) // 2021/6/28 14:48

// そもそも、デフォルトが.dateTimeで、1種類しかないっぽい
print(now.formatted(.dateTime.year()))                      // 2021
print(now.formatted(.dateTime.month()))                     // Jun
print(now.formatted(.dateTime.day()))                       // 28
print(now.formatted(.dateTime.day().month()))               // Jun 28
print(now.formatted(.dateTime.year().month()))              // Jun 2021
print(now.formatted(.dateTime.year().day().month()))        // Jun 28, 2021
print(now.formatted(.dateTime.year().day().month(.wide)))   // June 7, 2021
print(now.formatted(.dateTime.weekday(.wide)))              // Monday
print(now.formatted(.dateTime.dayOfYear()))                 // 179
print(now.formatted(.dateTime.hour()))                      // 2 PM
print(now.formatted(.dateTime.minute()))                    // 48
print(now.formatted(.dateTime.second()))                    // 20
print(now.formatted(.dateTime.timeZone()))                  // GMT+9

print(now.formatted(.dateTime.locale(Locale(identifier: "ja_JP")).year()))                      // 2021年
print(now.formatted(.dateTime.locale(Locale(identifier: "ja_JP")).month()))                     // 6月
print(now.formatted(.dateTime.locale(Locale(identifier: "ja_JP")).day()))                       // 28日
print(now.formatted(.dateTime.locale(Locale(identifier: "ja_JP")).day().month()))               // 6月28日
print(now.formatted(.dateTime.locale(Locale(identifier: "ja_JP")).year().month()))              // 2021年6月
print(now.formatted(.dateTime.locale(Locale(identifier: "ja_JP")).year().day().month()))        // 2021年6月28日
print(now.formatted(.dateTime.locale(Locale(identifier: "ja_JP")).weekday(.wide)))              // 月曜日
print(now.formatted(.dateTime.locale(Locale(identifier: "ja_JP")).hour()))                      // 16時
print(now.formatted(.dateTime.locale(Locale(identifier: "ja_JP")).timeZone()))                  // JST



// MARK: formatted(date, time)
print("formatted(date, time)の確認")
print(now.formatted(date: .omitted, time: .omitted))        // 6/28/2021, 2:48 PM
// omittedがデフォルト
// dateのパターン確認
print(now.formatted(date: .numeric, time: .omitted))        // 6/28/2021
print(now.formatted(date: .abbreviated, time: .omitted))    // Jun 28, 2021
print(now.formatted(date: .long, time: .omitted))           // June 28, 2021
print(now.formatted(date: .complete, time: .omitted))       // Monday, June 28, 2021
// timeのパターン確認
print(now.formatted(date: .omitted, time: .shortened))      // 2:48 PM
print(now.formatted(date: .omitted, time: .standard))       // 2:48:20 PM
print(now.formatted(date: .omitted, time: .complete))       // 2:48:20 PM GMT+9

print("出力用テキストの確認") // dashとomittedしかない
print(now.formatted(.iso8601.year().month().day().dateSeparator(.dash))) // 2021-06-28
print(now.formatted(.iso8601.year().month().day().dateSeparator(.omitted))) // 20210628

let later = now + TimeInterval(5000)
print((now..<later).formatted()) // 6/28/21, 2:33 – 3:56 AM
print((now..<later).formatted(date: .omitted, time: .standard)) // 2:33:33 PM – 3:56:53 PM
print((now..<later).formatted(.timeDuration)) // 1:23:20
print((now..<later).formatted(.components(style: .wide))) // 1 hour, 23 minutes, 20 seconds
print(later.formatted(.relative(presentation: .named, unitsStyle: .wide))) // in 1 hour

let format = Date.FormatStyle().year().day().month()
print(now.formatted(format)) // Jun 28, 2021
if let date = try? Date(now.formatted(format), strategy: format) {
    print(date) // example: 2021-06-27 15:00:00
}

let dashStrategy = Date.ParseStrategy(
    format: "\(year: .defaultDigits)-\(month: .twoDigits)-\(day: .twoDigits)",
    timeZone: TimeZone.current)
if let date = try? Date("2021-06-28", strategy: dashStrategy) {
    print(date) // 2021-06-27 15:00:00 +0000
}

//let strategy = Date.ParseStrategy(
//    format: "\(year: .defaultDigits)年\(month: .twoDigits)月\(day: .twoDigits)日",
//    timeZone: TimeZone.current)
//if let date = try? Date("2021-06-07", strategy: strategy) {
//    print(date) // 2021-06-06 15:00:00 +0000
//}



// ----------

print("---number formatted---")

let value = 12345
print(value.formatted()) // 12,345
print(value.formatted(.currency(code: "usd"))) // $12,345.00
print(value.formatted(.currency(code: "jpy"))) // ¥12,345

let percent = 25
// percentFormatted is "25%"
print(percent.formatted(.percent))

let scientific = 42e9
print(scientific.formatted(.number.notation(.scientific)))

// Note: This will use your current locale. Example output is for en_US locale.
let list = [25, 50, 75].formatted(.list(memberStyle: .percent, type: .or))
// list is "25%, 50%, or 75%"
print(list)
