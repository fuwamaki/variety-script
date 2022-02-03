import UIKit

indirect enum QuizAnswerType {
    case fraction(numeratorType: QuizAnswerType, denominatorType: QuizAnswerType) // 分数
    case formula(types: [QuizAnswerType]) // 式
    case mixed(mixedValue: Int, type: QuizAnswerType) // mixed（帯分数や 2√2など）
    case root(value: QuizAnswerType) // ルート
    case decimal(value: Double) // 小数
    case integer(value: Int) // 整数
    case plus // + 足し算
    case minus // - 引き算
}

// "\\frac{1+\\sqrt{2}}{3}" みたいなのが引数。
func fraction(_ latex: String) -> (numerator: String, denominator: String, other: String) {
    var latex = latex
    latex.removeSubrange(latex.range(of: "\\frac")!)
    // numerator
    var numeratorBracketCounter = 0
    let startNumeratorBracketIndex = latex.index(after: latex.firstIndex(of: "{")!)
    var endNumeratorBracketOffset: Int?
    for (offset, character) in latex.enumerated() {
        if character == "{" {
            numeratorBracketCounter += 1
        } else if character == "}" {
            numeratorBracketCounter -= 1
        }
        if numeratorBracketCounter == 0 {
            endNumeratorBracketOffset = offset-1
            break
        }
    }
    let endNumeratorBracketIndex = latex.index(startNumeratorBracketIndex, offsetBy: endNumeratorBracketOffset!)
    let numerator = String(latex[startNumeratorBracketIndex..<endNumeratorBracketIndex])
    latex.removeSubrange(latex.index(before: startNumeratorBracketIndex)...endNumeratorBracketIndex)

    // denominator
    var denominatorBracketCounter = 0
    let startDenominatorBracketIndex = latex.index(after: latex.firstIndex(of: "{")!)
    var endDenominatorBracketOffset: Int?
    for (offset, character) in latex.enumerated() {
        if character == "{" {
            denominatorBracketCounter += 1
        } else if character == "}" {
            denominatorBracketCounter -= 1
        }
        if denominatorBracketCounter == 0 {
            endDenominatorBracketOffset = offset-1
            break
        }
    }
    let endDenominatorBracketIndex = latex.index(startDenominatorBracketIndex, offsetBy: endDenominatorBracketOffset!)
    let denominator = String(latex[startDenominatorBracketIndex..<endDenominatorBracketIndex])

    // other
    latex.removeSubrange(latex.index(before: startDenominatorBracketIndex)...endDenominatorBracketIndex)
    return (numerator: numerator, denominator: denominator, other: latex)
}

// "\\sqrt{2}", "\\sqrt{1+\\sqrt{2}}" みたいなのが引数
func root(_ latex: String) -> (value: String, other: String) {
    var latex = latex
    latex.removeSubrange(latex.range(of: "\\sqrt")!)
    var bracketCounter = 0
    let startBracketIndex = latex.index(after: latex.firstIndex(of: "{")!)
    var endBracketOffset: Int?
    for (offset, character) in latex.enumerated() {
        if character == "{" {
            bracketCounter += 1
        } else if character == "}" {
            bracketCounter -= 1
        }
        if bracketCounter == 0 {
            endBracketOffset = offset-1
            break
        }
    }
    let endBracketIndex = latex.index(startBracketIndex, offsetBy: endBracketOffset!)
    let value = String(latex[startBracketIndex..<endBracketIndex])
    latex.removeSubrange(latex.index(before: startBracketIndex)...endBracketIndex)
    return (value: value, other: latex)
}

func latexType(_ latex: String) -> QuizAnswerType {
    if let int = Int(latex) {
        return .integer(value: int)
    } else if let double = Double(latex) {
        return .decimal(value: double)
    } else if latex == "+" {
        return .plus
    } else if latex == "-" {
        return .minus
    }

    // 先頭から順番に見ていく。先頭にはnumberか\しかありえない前提。
    var prefixStr = ""
    for character in latex {
        if character == "\\", prefixStr.isEmpty {
            // fracかsqrt始まり
            break
        } else if character == "\\", !prefixStr.isEmpty {
            // 先頭に数値があるので、mixed
            var tmp = latex
            tmp.removeSubrange(latex.range(of: prefixStr)!)
            return .mixed(mixedValue: Int(prefixStr)!, type: latexType(tmp))
        } else if character == "+" {
            var tmp = latex
            tmp.removeSubrange(latex.range(of: prefixStr + "+")!)
            return .formula(types: [.integer(value: Int(prefixStr)!), .plus, latexType(tmp)])
        } else if character == "-" {
            var tmp = latex
            tmp.removeSubrange(latex.range(of: prefixStr + "-")!)
            return .formula(types: [.integer(value: Int(prefixStr)!), .minus, latexType(tmp)])
        } else {
            prefixStr = prefixStr + String(character)
        }
    }

    // fracかsqrt始まりの場合
    if latex.contains("\\frac") { // "\\frac{numerator}{denominator}"
        let result = fraction(latex)
        if result.other.isEmpty {
            return .fraction(
                numeratorType: latexType(result.numerator),
                denominatorType: latexType(result.denominator)
            )
        } else {
            let type: QuizAnswerType = {
                if result.other.first == "+" {
                    return .plus
                } else if result.other.first == "-" {
                    return .minus
                } else {
                    fatalError()
                }
            }()
            var tmp = result.other
            tmp.removeFirst()
            return .formula(types: [
                .fraction(
                    numeratorType: latexType(result.numerator),
                    denominatorType: latexType(result.denominator)
                ),
                type,
                latexType(tmp)
            ])
        }
    } else if latex.contains("\\sqrt") {
        let result = root(latex)
        if result.other.isEmpty {
            return .root(value: latexType(result.value))
        } else {
            let type: QuizAnswerType = {
                if result.other.first == "+" {
                    return .plus
                } else if result.other.first == "-" {
                    return .minus
                } else {
                    fatalError()
                }
            }()
            var tmp = result.other
            tmp.removeFirst()
            return .formula(types: [
                .root(value: latexType(result.value)),
                type,
                latexType(tmp)
            ])
        }
    } else {
        fatalError()
    }
}

//latexType("\\frac{\\sqrt{2}+1}{3}")
//print(latexType("\\frac{1+\\sqrt{2}}{3}"))
print(latexType("2\\frac{2}{3}+1"))




// =====================================

// "を取る
var onlineTitle = "オンライン世界の果てまではいけない禍です【オンラインテスト】"
//if let range: Range = onlineTitle.range(of: "【オンライン】") {
//   onlineTitle.replaceSubrange(range, with:"")
//    print(onlineTitle)
//}
if let firstIndex = onlineTitle.firstIndex(of: "【"),
    let endIndex = onlineTitle.firstIndex(of: "】"),
    onlineTitle[firstIndex...endIndex].contains("オンライン") {
    print(onlineTitle[firstIndex...endIndex])
    onlineTitle.removeSubrange(firstIndex...endIndex)
    print(onlineTitle)
//    print(onlineTitle[onlineTitle.index(after: endIndex)...])
} else {
    print(onlineTitle)
}



let dateBetweenString: String = "6月18日(木) 19:00 - 22:00"

var kanjiyyyyMMdd: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM月dd日"
    dateFormatter.timeZone = TimeZone.current
    return dateFormatter
}

if let aaaaa = dateBetweenString.firstIndex(of: "日") {
    let ttt = dateBetweenString.prefix(through: aaaaa)
    print(kanjiyyyyMMdd.date(from: String(ttt)))
}


let kouzaUrl = URL(string: "https://www.street-academy.com/myclass/3212?conversion_name=direct_message&d_code=5uaBJx0i&tracking_code=b05159c62ebcadde19c74b5d497f9a67")!
print(kouzaUrl.absoluteString)
print(kouzaUrl.query)
print(kouzaUrl.pathComponents)
print(kouzaUrl.lastPathComponent)

let urlComponents = URLComponents(url: kouzaUrl, resolvingAgainstBaseURL: false)
let dCode = urlComponents?.queryItems?.filter { $0.name == "d_code" }.first?.value
print(dCode)

func queryValues(url: URL) -> [String: Any] {
    var values: [String: Any] = [:]
    let urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false)
    urlComponents?.queryItems?.forEach {
        values[$0.name] = $0.value
    }
    return values
}

print(queryValues(url: kouzaUrl))



func getIntervalDays(date: Date, anotherDay: Date? = nil) -> Int {
    let retInterval: Double = anotherDay == nil ? date.timeIntervalSinceNow : date.timeIntervalSince(anotherDay!)
    let ret = retInterval / 86400
    return Int(floor(ret))
}

var yyyyMMddHHmm: DateFormatter {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
    dateFormatter.timeZone = TimeZone.current
    return dateFormatter
}

let dateString = "2020/01/21 11:40"
let dateForm = yyyyMMddHHmm.date(from: dateString)!
print(getIntervalDays(date: dateForm))

func timeText(hours: Int, minutes: Int) -> String {
    switch (hours, minutes) {
    case (let hour, let minute) where hour == 0 && minute >= 30:
        return "1時間"
    case (let hour, let minute) where hour == 0 && minute >= 10 && minute < 30:
        return "30分"
    case (let hour, let minute) where hour == 0 && minute >= 5 && minute < 10:
        return "10分"
    case (let hour, let minute) where hour == 0 && minute > 1 && minute < 5:
        return "5分"
    case (let hour, let minute) where hour == 0 && minute <= 1:
        return "1分"
    default:
        // 残り時間数なので、繰り上げた値に（例：残り48分だったら、残り1時間表示）
        return "\(hours+1)時間"
    }
}

print(timeText(hours: 47, minutes: 23))
print(timeText(hours: 24, minutes: 00))
print(timeText(hours: 2, minutes: 1))
print(timeText(hours: 1, minutes: 00))
print(timeText(hours: 0, minutes: 47))
print(timeText(hours: 0, minutes: 14))
print(timeText(hours: 0, minutes: 6))
print(timeText(hours: 0, minutes: 3))
print(timeText(hours: 0, minutes: 0))


let data = ["category": ["name": "ランキング"]]
let aaa = try! JSONSerialization.data(withJSONObject: data, options: [])
print(aaa)
print("test")
guard let utf8Text = String(data: aaa, encoding: .utf8) else {
    fatalError()
}
let searchData = utf8Text.data(using: String.Encoding.utf8)!
let text = try! JSONSerialization.jsonObject(with: searchData, options: .allowFragments)
print(text)

// urlのHostだけ置き換え
let campaignUrl = URL(string: "https://google.com/campaign/test_dayo?app=true")!
var urlStr = campaignUrl.absoluteString
if let range = urlStr.range(of: "google.com") {
    urlStr.replaceSubrange(range, with: "sample.maki.com")
    print(urlStr)
}


let prefectureUrl = "https://google.com/test?prefecture=13"
let components = URLComponents(url: URL(string: prefectureUrl)!, resolvingAgainstBaseURL: false)
let hasPrefecture = components?.query?.contains("prefectura")
print(hasPrefecture!)

// StringをDate型に変換
let time = "2019/11/17 19:11"
var dateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy/MM/dd HH:mm"
    dateFormatter.timeZone = TimeZone.current
    return dateFormatter
}()

var displayDateFormatter: DateFormatter = {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "MM/dd HH:mm"
    dateFormatter.timeZone = TimeZone.current
    return dateFormatter
}()

if let date = dateFormatter.date(from: time) {
    if date.compare(Date()) == ComparisonResult.orderedDescending {
        print("期限は今日よりも未来")
    } else {
        print("期限は今日よりも過去")
    }
    print(displayDateFormatter.string(from: date))
}


// "を取る
var word = "学び\""
print(word.contains("\"") ? word.replacingOccurrences(of: "\"", with: "") : word)


let count: Int = 5
// 閉区間の確認
for status in 1...count {
    print(status)
}

let url = URL(string: "https://api-2.street-academy.com/special/60?trigger=special_top")!
let path = url.path

// componentsでうまくとれた
let array = path.components(separatedBy: "/")
if array.contains("special"), let lastArray = array.last, let number = Int(lastArray) {
    print(number)
}

// rangeではうまくとれなかった...
if let range = path.range(of: "special/") {
    print(path[range])
}
let firstIndex = path.firstIndex(of: "/")!
let endIndex = path.firstIndex(of: "0")!
print(path[firstIndex...endIndex])


let start = Date()

//function which takes another function as its argument

func getBirthDaySentence(name: String, dateGetter: (String) -> String ) -> String
{
    return "The birthday of \(name) is \(dateGetter(name))"
}

func getBirthday(name: String ) -> String
{
    if name == "John Appleseed" {
        return "12/5"
    }else{
        return "unknown"
    }
}

print(getBirthDaySentence(name: "John Appleseed", dateGetter: getBirthday))

public let apples = 3
public let oranges = 5
public let appleSummary = "I have \(apples) apples."
public let fruitSummary = "I have \(apples + oranges) pieces of fruit."


// test about rangeOfComposedCharacterSequenceAtIndex

let name = NSString(string: "abcdefghijk")
let range = name.rangeOfComposedCharacterSequence(at: 0)
let nameId = name.substring(with: range).uppercased()
print(nameId)
let textsss: String = "あかさたなはまやらわ"
let prefix = textsss.prefix(1)
print(textsss.prefix(1))


let brands = ["アイ", "アウ", "アエ", "イシ", "イス", "ウマ"]
var startIndexs: [String] = []

struct Brand {
    let section: String
    let name: String

    init(section: String, name: String) {
        self.section = section
        self.name = name
    }
}

var setBrands: [Brand] = []
brands.forEach {
    setBrands.append(Brand(section: String($0.prefix(1)), name: $0))
    startIndexs.append(String($0.prefix(1)))
}
if let orderedSetBrandIndexes = NSOrderedSet(array: startIndexs).array as? [String] {
    startIndexs = orderedSetBrandIndexes
}
print(setBrands)

print(startIndexs)

startIndexs.forEach { section in
    print(setBrands.filter({$0.section == section}).count)
}

print("チェックA\(Date().timeIntervalSince(start))")

private func filteringMetadataObject(value: String) -> String? {
    let int64Value = NSString(string: value).longLongValue
    let prefix2: Int64 = Int64(int64Value / Int64(pow(10.0, 11.0)))
    if prefix2 == 45 || prefix2 == 49 { return value }
    let prefix3: Int64 = Int64(int64Value / Int64(pow(10.0, 10.0)))
    if prefix3 == 978 || prefix3 == 979 { return value }
    return nil
}

print(filteringMetadataObject(value: "9781818292945") ?? "nilやで")
print(filteringMetadataObject(value: "9381818292945") ?? "nilやで")
print(filteringMetadataObject(value: "9791818292945") ?? "nilやで")
print(filteringMetadataObject(value: "9771818292945") ?? "nilやで")
print(filteringMetadataObject(value: "4591818292945") ?? "nilやで")
print(filteringMetadataObject(value: "4491818292945") ?? "nilやで")
print(filteringMetadataObject(value: "4991818292945") ?? "nilやで")
print(filteringMetadataObject(value: "98292945") ?? "nilやで")

// =====================================

