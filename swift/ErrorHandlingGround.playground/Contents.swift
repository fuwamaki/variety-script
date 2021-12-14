//: Playground - noun: a place where people can play

import UIKit

enum ErrorType:Error {
    case InvalidValue
}

func doubleUp(_ value:Int) throws -> Int {
    if value < 0 {
        throw ErrorType.InvalidValue
    }
    var x = value
    for index in 1...100000 {
        x = x + index
    }
    return x
}

do {
    defer {print("処理終了時間：\(Date())")} //deferは、終了時に必ず行う処理
    print("処理開始時間：\(Date())")
    var _ = try doubleUp(10)
} catch ErrorType.InvalidValue {
    print("エラー発生")
}
