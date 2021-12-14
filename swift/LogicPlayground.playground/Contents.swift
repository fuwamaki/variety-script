import UIKit

print(sqrt(2.0)) // ルート（平方根） 1.4142135623730951
print(pow(3, 2)) // 乗算 9
print(pow(3, 3)) // 乗算 27
print(abs(-3)) // 正数 3
print(fabs(-3)) // 小数 3.0
print(Int.random(in: 1..<10)) // 乱数
print(Double.random(in: 1..<10)) // 乱数
print(Float.random(in: 1..<10)) // 乱数
print(Bool.random()) // 乱数 true or false
print(UUID().uuidString)
print([0, 1, 2, 3].shuffled()) // シャッフル
print([0, 1, 2, 3].randomElement()) // ランダムに1つ（空配列の場合はnil）
print(ceil(5.3)) // 切り上げ 6.0
print(floor(3.7)) // 切り捨て 3.0
print(round(4.6)) // 四捨五入 5.0
print(log10(100.0)) // 対数 2.0



//var greeting = "Hello, playground"
//
//var array0: [Date] = [Date()]
//var array1: [Date] = [Date()]
//
//extension Date {
//    var yyyyMMddHHmmss: String {
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "yyyy/MM/dd HH:mm:ss"
//        dateFormatter.timeZone = TimeZone.current
//        return dateFormatter.string(from: self)
//    }
//}
//
//print(array0 == array1)
//print(array0.compactMap({$0.yyyyMMddHHmmss}) == array1.compactMap({$0.yyyyMMddHHmmss}))
//print(array0.yyyyMMddHHmmss == array1.yyyyMMddHHmmss)
//
//extension Array where Element == Date {
//    var yyyyMMddHHmmss: [String] {
//        self.compactMap({$0.yyyyMMddHHmmss})
//    }
//}

//struct Entity: Equatable {
//    let id: Int
//    let name: String
//
//    static func == (lhs: Entity, rhs: Entity) -> Bool {
//        return lhs.id == rhs.id
//    }
//}
//
//var entity0 = Entity(id: 0, name: "name0")
//var entity1 = Entity(id: 1, name: "name1")
//var entity2 = Entity(id: 2, name: "name2")
//var entity2dash = Entity(id: 2, name: "name3")
//
//var entityList0: [Entity] = [entity0, entity1, entity2]
//var entityList1: [Entity] = [entity0, entity1, entity2dash]
//
//print(entityList0 == entityList1)



struct Entity: Equatable {
    let id: Int
    let name: String
}

let entity0 = Entity(id: 0, name: "name0")
let entity0a = Entity(id: 0, name: "name0a")
let entity1 = Entity(id: 1, name: "name1")
let entity1a = Entity(id: 1, name: "name1a")
let entity2 = Entity(id: 2, name: "name2")
let entity2a = Entity(id: 2, name: "name2a")

let entityList0: [Entity] = [entity0, entity1, entity2]
let entityList1: [Entity] = [entity0a, entity1a, entity2a]

print(entityList0 == entityList1)
