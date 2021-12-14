import UIKit

let array1: [Int] = [1, 2, 3, 4, 5]
let array2: [String] = ["白", "黒"]

//let array3 = array1
//    .compactMap { num in
//        array2.compactMap { color in
//            return num.description + color
//        }
//    }
//    .flatMap { $0 }
//
//print(array3)

let array = array1
    .compactMap { num in
        array2.compactMap { color in
            (num, color)
        }
    }
    .flatMap { $0 }
    .compactMap { num, color in
        num.description + color
    }
print(array)

func combine<E1, E2>(_ arr1: [E1], _ arr2: [E2]) -> [(E1, E2)] {
    guard !arr1.isEmpty && !arr2.isEmpty else {
        return []
    }
    func _c(_ e1: E1, _ arr2: [E2]) -> [(E1, E2)] {
        return arr2.map{(e1, $0)}
    }
    return _c(arr1[0], arr2) + combine(arr1.dropFirst().map{$0}, arr2)
}

let array4 = combine(array1, array2)
//    .map { $0.0.description + $0.1 }
print(array4.map { $0.0.description + $0.1 })

