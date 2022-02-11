import UIKit

// 切り取り remove
var name1 = "木村文乃"
if let range = name1.range(of: "文乃") {
    name1.removeSubrange(range)
    print(name1)
}

// 切り取り remove
var name2 = "木村文乃"
if let range = name2.range(of: "文乃") {
    name2.replaceSubrange(range, with: "")
    print(name2)
}

// 置き換え
var name3 = "木村文乃"
if let range = name3.range(of: "文") {
    name3.replaceSubrange(range, with: "佳")
    print(name3)
}

// index
var text1 = "隣の客はよく柿食う客だ"

print(text1.startIndex) // Index(_rawBits: 1)
print(text1.startIndex.utf16Offset(in: text1)) // 0

print(text1.firstIndex(of: "客")!) // Index(_rawBits: ******)
print(text1.firstIndex(of: "客")!.utf16Offset(in: text1)) // 2

print(text1.endIndex) // Index(_rawBits: ******)
print(text1.endIndex.utf16Offset(in: text1)) // 11

let persimmonIndex = text1.firstIndex(of: "柿")!

print(text1.prefix(5)) // 隣の客はよ
print(text1.prefix(through: persimmonIndex)) // 隣の客はよく柿
print(text1.prefix(upTo: persimmonIndex)) // 隣の客はよく
print(text1.hasPrefix("柿")) // false
print(text1.hasPrefix("隣")) // true
print(text1.hasPrefix("隣の客")) // true

print(text1.suffix(3)) // う客だ
print(text1.suffix(from: persimmonIndex)) // 柿食う客だ
print(text1.hasSuffix("柿")) // false
print(text1.hasSuffix("だ")) // true
print(text1.hasSuffix("客だ")) // true

print(text1[..<persimmonIndex]) // 隣の客はよく
print(text1[...persimmonIndex]) // 隣の客はよく柿

print(text1[..<text1.index(before: persimmonIndex)]) // 隣の客はよ
print(text1[..<text1.index(after: persimmonIndex)]) // 隣の客はよく柿

print(text1[..<text1.index(persimmonIndex, offsetBy: 1)]) // 隣の客はよ柿
print(text1[..<text1.index(persimmonIndex, offsetBy: 2)]) // 隣の客はよ柿食
print(text1[..<text1.index(persimmonIndex, offsetBy: -1)]) // 隣の客はよ

// successor(), predecessor() はもう使えない

var text2 = "欲しいのは【金メダル】だ"

if let startBracketIndex: String.Index = text2.firstIndex(of: "【"),
   let endBracketIndex: String.Index = text2.firstIndex(of: "】") {
    let subSequence: String.SubSequence = text2[startBracketIndex...endBracketIndex]
    print(subSequence) // 【金メダル】
    let text = String(subSequence)
    print(text) // 【金メダル】
}

if let startBracketIndex: String.Index = text2.firstIndex(of: "【"),
   let endBracketIndex: String.Index = text2.firstIndex(of: "】") {
    let subSequence: String.SubSequence = text2[startBracketIndex..<endBracketIndex]
    print(subSequence) // 【金メダル
}

if let startBracketIndex: String.Index = text2.firstIndex(of: "【"),
   let endBracketIndex: String.Index = text2.firstIndex(of: "】") {
    let startBracketIndex2: String.Index = text2.index(startBracketIndex, offsetBy: 1)
    let subSequence: String.SubSequence = text2[startBracketIndex2..<endBracketIndex]
    print(subSequence) // 金メダル
}

if let startBracketIndex: String.Index = text2.firstIndex(of: "【"),
   let endBracketIndex: String.Index = text2.firstIndex(of: "】") {
    let startBracketIndex2: String.Index = text2.index(after: startBracketIndex)
    let subSequence: String.SubSequence = text2[startBracketIndex2..<endBracketIndex]
    print(subSequence) // 金メダル
}


// range(of: )
var text3 = "カバンの中にはイヤホンが入っている"
let range3: Range<String.Index> = text3.range(of: "イヤホン")!
print(range3) // Index(_rawBits: ******)..<Index(_rawBits: ******)
print(text3[range3]) // イヤホン

text3.removeSubrange(text3.range(of: "イヤホン")!)
print(text3) // カバンの中にはイヤホンが入っている

var text4 = "カバンの中にはイヤホンが入っている"
text4.replaceSubrange(text4.range(of: "イヤホン")!, with: "チョコボール")
print(text4) // カバンの中にはチョコボールが入っている


// remove
var text5 = "0123456789"
text5.removeAll()
print(text5) // ""

var text6 = "0123456789"
text6.removeFirst()
print(text6) // 123456789

var text7 = "0123456789"
text7.removeLast()
print(text7) // 012345678

var text8 = "0123456789"
text8.removeFirst(3)
print(text8) // 3456789

var text9 = "0123456789"
text9.removeLast(4)
print(text9) // 012345

var text91 = "0123456789"
text91.popLast()
print(text91) // 012345678

// dropLastは返却値。変数の値を変えない
let text92 = "0123456789"
print(text92.dropLast()) // 012345678
print(text92.dropLast(3)) // 0123456

var spaceText = ""
// spaceText.removeLast() // Fatal error: Can't remove last element from an empty collection
spaceText.popLast() // エラーにならない

// contain
var text10 = "週刊少年ジャンプ"
print(text10.contains("ン")) // true
print(text10.contains("少年")) // true
print(text10.contains("ん")) // false
print(text10.contains("")) // false

// add
var text11 = "平均"
text11.append(contentsOf: "末尾に")
print(text11)
text11 += "つく"
print(text11)

text11.insert("前", at: text11.startIndex)
// text11.insert("前につく", at: text11.startIndex) エラー。Characterのみ
print(text11)

// starts

var text12 = "週刊少年ジャンプ"
print(text12.starts(with: "週刊")) // true

// first, last
print(text12.first!) // 週
print(text12.last!) // プ

// substringはdeprecated


// 複数 remove replace

var text13 = "ビビデバビデブー"
text13.removeSubrange(text13.range(of: "ビデ")!)
// 最初の一つだけ
print(text13) // ビバビデブー

var text14 = "ビビデバビデブー"
print(text14.replacingOccurrences(of: "ビデ", with: "")) // ビバブー
// 全部変えられる
print(text14.replacingOccurrences(of: "ビデ", with: "びで")) // ビびでバびでブー


// ----------------------------------

var numbersText = "1,1,2,3,5,8,13"
print(numbersText.split(separator: ",")) // ["1", "1", "2", "3", "5", "8", "13"]
print(numbersText.split(separator: ",").compactMap({ Int($0) })) // [1, 1, 2, 3, 5, 8, 13]

var fruitsText = "りんご&みかん&もも&いちご"
var array = fruitsText.split(separator: "&")
print(array) // ["りんご", "みかん", "もも", "いちご"]
var arrayText = array.joined(separator: ", ")
print(arrayText) // りんご, みかん, もも, いちご


// 応用①

var sqrt = "\\sqrt{2}"

if let startBracketIndex = sqrt.firstIndex(of: "{"),
   let endBracketIndex = sqrt.firstIndex(of: "}") {
    let subSequence = sqrt[sqrt.index(after: startBracketIndex)..<endBracketIndex]
    print(subSequence) // 2
}

// 応用②

func numerator(_ frac: String) -> String {
    var frac = frac
    frac.removeSubrange(frac.range(of: "\\frac")!)
    let startIndex = frac.firstIndex(of: "{")!
    var endIndex: String.Index {
        var index: Int = 0
        frac.enumerated().forEach { value in
            var bracketCounter = 0
            if value.element == "{" {
                bracketCounter += 1
            } else if value.element == "}" {
                bracketCounter -= 1
            }
            if bracketCounter == 0 {
                index = value.offset
            }
        }
        return frac.index(startIndex, offsetBy: index-1)
    }
    return String(frac[frac.index(after: startIndex)..<frac.index(before: endIndex)])
}

var formula1 = "\\frac{1}{3}"
if formula1.starts(with: "\\frac") {
    print(numerator(formula1)) // 1
}

var formula2 = "\\frac{1+\\sqrt{2}}{3}"
if formula2.starts(with: "\\frac") {
    print(numerator(formula2)) // 1+\sqrt{2}
}

var formula3 = "\\frac{\\sqrt{2}+\\sqrt{3}}{3}"
if formula3.starts(with: "\\frac") {
    print(numerator(formula3)) // \sqrt{2}+\sqrt{3}
}
