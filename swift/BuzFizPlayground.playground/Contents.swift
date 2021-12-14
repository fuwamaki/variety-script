import UIKit

var str = "Hello, playground"

(1...100)
    .map {
        switch ($0 % 3, $0 % 5) {
        case (0, 0):
            return "FizzBuzz"
        case (_, 0):
            return "Buzz"
        case (0, _):
            return "Fizz"
        default:
            return String($0)
        }
    }
    .forEach { print($0) }

(1...100).forEach {
    switch ($0 % 3, $0 % 5) {
    case (0, 0):
        print("FizzBuzz")
    case (_, 0):
        print("Buzz")
    case (0, _):
        print("Fizz")
    default:
        print($0)
    }
}

for x in 1...100 {
    if x % 3 == 0 && x % 5 == 0 {
        print("FizzBuzz")
    } else if x % 5 == 0 {
        print("Buzz")
    } else if x % 3 == 0 {
        print("Fizz")
    } else {
        print(x)
    }
}

// 時間テスト
let now = "2017/8/12"
let formatter = DateFormatter()
formatter.dateFormat = "yyyy/MM/dd"
formatter.locale = Locale(identifier: "ja_JP")
if let date = formatter.date(from: now) {
    let days = Calendar.current.dateComponents([.day], from: date, to: Date()).day
//    let days = Calendar.current.dateComponents([.day], from: date).day
    print(days)
}


// 文字列分割テスト
let urlStr = "fril://brand/50"
let url = URL(string: urlStr)!

var brandUrl = url.absoluteString
if let range = brandUrl.range(of: "fril://brand/") {
    brandUrl.removeSubrange(range)
    if let brandId = Int(brandUrl) {
        print(brandId)
    }
}


// [String: Any]を深ぼる
let document: [String: Any] = ["user_id": "qwerty"]

