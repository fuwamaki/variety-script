//: Playground - noun: a place where people can play

import UIKit

//アンラップ処理

var value:String?
value = "こんにちは"

if let _ = value {
    print("valueの値を使っていないので、アンラップ処理にしている")
}

if let a = value {
    print("アンラップ処理にしていないと、警告が出てしまう")
}

//引数名の省略

func desuneText(_ value:String) -> String {
    return(value + "ですね")
}
print(desuneText("省略できるタイプ"))

func degozaruText(value:String) -> String {
    return(value + "でござる")
}
print(degozaruText(value: "省略できない"))

