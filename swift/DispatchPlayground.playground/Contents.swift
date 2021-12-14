import UIKit

var str = "Hello, playground"

class DispatchPlayGround {

    //並列処理
    func doParallelMultiAsyncProcess() {
        let dispatchGroup = DispatchGroup()
        // .concurrentを付けると並列処理
        let dispatchQueue = DispatchQueue(label: "queue", attributes: .concurrent)

        // 5つの非同期処理を実行
        for i in 1...5 {
            dispatchGroup.enter()
            dispatchQueue.async(group: dispatchGroup) { [weak self] in
                self?.asyncProcess(number: i) {
                    (number: Int) -> Void in
                    print("#\(number) End")
                    dispatchGroup.leave()
                }
            }
        }

        // 全ての非同期処理完了後にメインスレッドで処理
        dispatchGroup.notify(queue: .main) {
            print("All Process Done!")
        }
    }

    // 直列処理
    func doSeriesMultiAsyncProcess() {
        let dispatchGroup = DispatchGroup()
        // 直列キュー / attibutes指定なし
        let dispatchQueue = DispatchQueue(label: "queue")

        // 5つの非同期処理を実行
        for i in 1...5 {
            dispatchGroup.enter()
            dispatchQueue.async(group: dispatchGroup) {
                [weak self] in
                self?.asyncProcess(number: i) {
                    (number: Int) -> Void in
                    print("#\(number) End")
                    dispatchGroup.leave()
                }
            }
        }

        // 全ての非同期処理完了後にメインスレッドで処理
        dispatchGroup.notify(queue: .main) {
            print("All Process Done!")
        }
    }
    
    // 非同期処理
    func asyncProcess(number: Int, completion: (_ number: Int) -> Void) {
        print("#\(number) Start")
        sleep((arc4random() % 100 + 1) / 100) // ランダムな時間Sleep
        completion(number)
    }
}

let playground = DispatchPlayGround()
print("---直列処理---")
//playground.doSeriesMultiAsyncProcess()
//sleep(2)
print("---並列処理---")
playground.doParallelMultiAsyncProcess()

