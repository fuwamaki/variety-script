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

        // 今までのLabel表示。attributes利用。
        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.attributedText = NSAttributedString(
            string: "既存Hello World!!",
            attributes: attributes
        )
        view.addSubview(label)

        // 新しいAttributedString
        do {
            var attributedString = try AttributedString(markdown: "**New World!!**")
            attributedString.font = .body.bold()
            attributedString.foregroundColor = .red
            //        var container = AttributeContainer()
            //        container.foregroundColor = .red
            //        container.underlineColor = .cyan
            //        attributedString.mergeAttributes(container)

            // 2021/6時点: AttributedString設定内容が全く適用されない状態。
            var buttonConfig = UIButton.Configuration.plain()
            buttonConfig.attributedTitle = attributedString
            let button = UIButton(configuration: buttonConfig)
            button.frame = CGRect(x: 100, y: 300, width: 200, height: 20)
            view.addSubview(button)

            // 2021/6時点: LabelにはAttributedStringを適用できない状態。
            let newLabel = UILabel()
            newLabel.attributedText = NSAttributedString(attributedString)
            newLabel.frame = CGRect(x: 100, y: 500, width: 200, height: 20)
            view.addSubview(newLabel)

            self.view = view
        } catch {
            fatalError()
        }
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
