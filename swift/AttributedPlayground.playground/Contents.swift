//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let attributes: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray,
            .backgroundColor: UIColor.yellow,
            .font : UIFont.systemFont(ofSize: 20.0)
        ]

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.attributedText = NSAttributedString(
            string: "Hello World!!",
            attributes: attributes)

        var attributedString = AttributedString("New World!!")
        attributedString.font = .body.bold()
        attributedString.foregroundColor = .green
        var container = AttributeContainer()
        container.foregroundColor = .red
        container.underlineColor = .primary
        attributedString.mergeAttributes(container)

        // 2021/6時点: AttributedString設定内容が全く適用されない状態。
        var buttonConfig = UIButton.Configuration.plain()
        buttonConfig.attributedTitle = attributedString
        let button = UIButton(configuration: buttonConfig)
        button.frame = CGRect(x: 100, y: 300, width: 200, height: 20)

        // 2021/6時点: LabelにはAttributedStringを適用できない状態。
//        let newLabel = UILabel()
//        newLabel.frame =
//        newLabel.attributedText = NSAttributedString(attributedString)

        view.addSubview(label)
        view.addSubview(button)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
