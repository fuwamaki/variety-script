//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController: UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .backgroundColor: UIColor.yellow,
            .font : UIFont.systemFont(ofSize: 20.0)
        ]

        let textView = UITextView(frame: CGRect(x: 50, y: 200, width: 200, height: 200))
        textView.attributedText = NSAttributedString(string: "Hello World!!", attributes: attributes)
        textView.delegate = self
        view.addSubview(textView)

        self.view = view
    }
}

extension MyViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.black,
            .backgroundColor: UIColor.clear,
            .font : UIFont.systemFont(ofSize: 20.0)
        ]
        textView.attributedText = NSAttributedString(string: textView.text ?? "", attributes: attributes)
    }
}

// keyboardサイズ大きすぎる問題の対処
// https://psobko.github.io/Xcode-Playground-Keyboards/

let window = UIWindow(frame: CGRect(x: 0, y: 0, width: 768, height: 1024))
let viewController = MyViewController()
window.rootViewController = viewController
window.makeKeyAndVisible()
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = window
