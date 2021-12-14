import UIKit

var greeting = "Hello, playground"

class Counter {
    var value = 0
    func increment() -> Int {
        value = value + 1
        return value
    }
}

let counter = Counter()

asyncDetached {
    print(counter.increment())
}

asyncDetached {
    print(counter.increment())
}

print("a")
