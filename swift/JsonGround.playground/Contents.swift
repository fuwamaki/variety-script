//: Playground - noun: a place where people can play

import UIKit
import Foundation

struct User {
    var id:Int
    var name:String
    var department:String
}


func jsonParser(data: Data) {
    do {
        //JSON文字列をパース
        guard let json:[AnyHashable:Any] = try JSONSerialization.jsonObject(with: data) as? [AnyHashable:Any] else {
            return
        }
        
        guard let id:Int = json["id"] as? Int,
            let name:String = json["name"] as? String,
            let department:String = json["department"] as? String else {
                return
        }
        
        let userData = User(id: id, name: name, department: department)
        print(userData)
    } catch {
    }
    
}

// JSON文字列作成 & Data型に変換
let jsonString = "{\"id\":22, \"name\":\"remu\", \"department\":\"maid\"}"
let jsonData: Data =  jsonString.data(using: String.Encoding.utf8)!
jsonParser(data: jsonData)


// MARK: Codableを用いたJSONのDecode・Encode

struct Live:Codable {
    var id:Int
    var artist:String
    var starttime:String
}

func liveDecode(data:Data) {
    //decode
    let live = try? JSONDecoder().decode(Live.self, from: data)
    
    //encode
    let encoder = JSONEncoder()
    encoder.outputFormatting = .prettyPrinted
    let encoded = try! encoder.encode(live)
    
    print(String(data: encoded, encoding: .utf8)!)
}

let jsonLiveStr = "{\"id\":20180214, \"artist\":\"scandal\", \"starttime\":\"1930\"}"
let jsonLiveData = jsonLiveStr.data(using: String.Encoding.utf8)!
liveDecode(data: jsonLiveData)
