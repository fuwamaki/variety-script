import UIKit

// if文が進化したぞ
var displayName: String? = "test"

let coun: Int
if let displayName, !displayName.isEmpty {
    coun = displayName.count
} else {
    coun = 999
}
print(coun)

let count: Int = {
    if let displayName, !displayName.isEmpty {
        displayName.count
    } else {
        999
    }
}()
print(count)

let countA: Int = if let displayName, !displayName.isEmpty {
    displayName.count
} else {
    999
}
print(countA)

var one = 1
let test: String = if one == 1 { "one" }
else { "other" }

print(test)

// switch文が進化したぞ
enum Gender {
    case male
    case female
    case other

    var text: String {
        return switch self {
        case .male: "man"
        case .female: "female"
        case .other: "other"
        }
    }
}

let male: Gender = .male
let genderText = switch male {
case .male:
    "male"
case .female:
    "female"
case .other:
    "other"
}

print(genderText)


// enumが進化
// Macrosまだ動かない
//@CaseDetection
//enum Time {
//    case morning
//    case daytime
//    case evening
//}
//
//let time: Time = .morning
//time.isMorning
