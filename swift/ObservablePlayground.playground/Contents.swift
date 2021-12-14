
print("start")

func fib(_ x: Int) -> Int {
    if x < 2 { return x }
    var first: Int = 0
    var second: Int = 1
    for _ in 0...(x-2) {
        let temp = second
        second = first + second
        first = temp
    }
    return second
}

print(fib(0))
print(fib(1))
print(fib(2))
print(fib(3))
print(fib(4))
print(fib(5))
print(fib(6))
print(fib(7))
print(fib(8))
print(fib(9))
print(fib(10))


func fib2(_ index: Int) -> Int {
    return index < 2 ? index : fib2(index-1) + fib2(index-2)
}

print(fib2(1))
print(fib2(2))
print(fib2(3))
print(fib2(4))
print(fib2(5))
print(fib2(6))
print(fib2(7))
print(fib2(8))
print(fib2(9))
print(fib2(10))
