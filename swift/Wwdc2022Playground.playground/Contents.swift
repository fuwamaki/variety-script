import UIKit
import RegexBuilder

print("axbcdefg".starts(with: /a(.*)b/))
print("caxb".starts(with: /a(.*)b/))

let sentence = "user_id: 123, name: fuwamaki"
print(sentence.replacing(/user_id:\s*(\d+)/, with: "456")) // "456, name: fuwamaki"
print(sentence.trimmingPrefix(/user_id:\s*(\d+)/)) // ", name: fuwamaki"


//let regex10 = try Regex("a(.*)b")
if let match = "zaxb".prefixMatch(of: /a(.*)b/) {
    print(match.0) // "axb"
    print(match.1) // "x"
}

if let match = "cbaxbcyyd".firstMatch(of: /a(.*)bc(.*)d/) {
    print(match.0) // "axb"
    print(match.1) // "x"
    print(match.2) // "yy"
    print(match.output.0) // "axb"
    print(match.output.1) // "x"
    print(match.output.2) // "yy"
}

let text = "税抜¥20,000は、税込にすると¥22,000"
let regexYen = /¥[\d|,]+/
if let match = text.firstMatch(of: regexYen) {
    print(match.0) // "¥20,000"
}

//print(text.replacing(regexYen, with: "456"))
let aaa = text.replacing(regexYen) { match in
    match.output.replacing(/¥/, with: "") + "円"
}
print(aaa)

let text2 = "お会計は2,022円になります"
if let match = text2.firstMatch(of: /[\d|,]+円/) {
    print(match.0)
}

if let ha = text2.firstIndex(of: "は"),
    let yen = text2.firstIndex(of: "円") {
    print(text2[text2.index(after: ha)...yen])
}

let longText = """
かえるのうたが きこえてくるよ
クワクワクワクワ ケロケロケロケロクワクワクワ
"""
let regexForLong = /くるよ\n/
let bbb = longText.firstMatch(of: regexForLong)
print(bbb?.output)

//var greeting: String? = "Hello, playground"
//if let greeting {
//    print(greeting)
//}

//let transaction = "DEBIT     03/05/2022    Doug's Dugout Dogs         $33.27"
//print(transaction)
//let normalized = transaction.replacing(/\s{2,}|\t/, with: "\t")
//print(normalized)

//let text = "Check out all the latest WWDC'22 updates at iOS Academy"
//do {
//    let search = try Regex("[a-z]iOS")
//    let range = text.ranges(of: search)
//    print(String(describing: range))
//} catch {}

//print("café".elementsEqual("cafe\u{301}"))
//print("café".unicodeScalars.elementsEqual("cafe\u{301}".unicodeScalars))
//print("café".utf8.elementsEqual("cafe\u{301}".utf8))

//let input = "name:  John Appleseed,  user_id:  100"
//let regex = try Regex(#"user_id:\s*(\d+)"#)
//if let match = input.firstMatch(of: regex) {
//    print("Matched: \(match[0])")
//    print("User ID: \(match[1])")
//}

let input = "name:  John Appleseed,  user_id:  100"
let regex1 = /user_id:\s*(\d+)/
//let regex = Regex {
//    "user_id:"
//    ZeroOrMore(.whitespace)
//    Capture {
//        OneOrMore(.digit)
//    }
//}
if let match = input.firstMatch(of: regex1) {
    print("Matched: \(match.0)")
    print("User ID: \(match.1)")
    print("User ID: \(match.output)")
    print("User ID: \(match.output.0)")
    print("User ID: \(match.output.1)")
}

let regex = Regex {
    "Hi, WWDC"
    Repeat(count: 2) {
        One(.digit)
    }
    "!"
}











//let regex2 = Regex {
//    "Hi, WWDC"
//    Repeat(.digit, count: 2)
//    "!"
//}
if let match2 = "Hi, WWDC22!".firstMatch(of: regex) {
    print("Result: \(match2.0)")
}

let regex3 = Regex {
    OneOrMore("a")
    OneOrMore(.digit)
}

if let match = "aaa12".wholeMatch(of: regex3) {
    print(match.0)
}

let input4 = "name:  John Appleseed,  user_id:  100"
let regex4 = /user_id:\s*(\d+)/
input4.firstMatch(of: regex4)           // Regex.Match<(Substring, Substring)>
input4.wholeMatch(of: regex4)           // nil 全体がマッチしているかどうか
input4.prefixMatch(of: regex4)          // nil テキストの前半部分がマッチしているかどうか
input4.starts(with: regex4)             // false
input4.replacing(regex4, with: "456")   // "name:  John Appleseed,  456"
input4.trimmingPrefix(regex4)           // "name:  John Appleseed,  user_id:  100"
//input4.split(separator: /\s*,\s*/)     // ["name:  John Appleseed", "user_id:  100"]
//switch "abc" {
//case /\w+/:
//    print("It's a word!")
//}

let input5 = "name: fuwa, user_id: 222"
let regex5 = /name:\s*(\w+)/
if let match = input5.prefixMatch(of: regex5) { print(match.1) }

let statement = """
    DSLIP    04/06/20 Paypal  $3,020.85
    CREDIT   04/03/20 Payroll $69.73
    DEBIT    04/02/20 Rent    ($38.25)
    DEBIT    03/31/20 Grocery ($27.44)
    DEBIT    03/24/20 IRS     ($52,249.98)
    """

let regex6 = Regex {
//    Capture(.date(format: "\(month: .twoDigits)/\(day: .twoDigits)/\(year: .twoDigits)"))
    OneOrMore(.whitespace)
    OneOrMore(.word)
    OneOrMore(.whitespace)
//    Capture(.currency(code: "USD").sign(strategy: .accounting))
}
//if let match = statement.firstMatch(of: regex6) { print(match.1) }


let regex7 = /name:\s*(\wgaujf9843onr-^fvao+)/
