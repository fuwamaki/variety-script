//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let balloonView = BalloonView()
        balloonView.setText("開催リクエストありがとうございます！\nオンラインは平日20:00以降リクエスト歓迎です\nその他ご相談があればメッセージにて気軽にお問い合わせください。平日は仕事の都合で返信が遅くなる場合あります。")
        self.view = balloonView
        self.view.backgroundColor = UIColor.red
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

@IBDesignable
final class BalloonView: UIView {

    let triangleSideLength: CGFloat = 13
    let triangleHeight: CGFloat = 5

    private lazy var textLabel: UILabel = {
        let textLabel = UILabel(frame: CGRect(x: 0, y: 0, width: frame.width-16, height: frame.height))
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textLabel.textColor = UIColor.black
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        textLabel.font = UIFont.systemFont(ofSize: 16.0)
        return textLabel
    }()

    private lazy var rightCorner: CGPoint = {
        return CGPoint(x: (frame.width + triangleSideLength) / 2,
                       y: triangleHeight)
    }()

    private lazy var leftCorner: CGPoint = {
        return CGPoint(x: (frame.width - triangleSideLength) / 2,
                       y: triangleHeight)
    }()

    private lazy var topCorner: CGPoint = {
        return CGPoint(x: frame.width / 2,
                       y: CGFloat(0.0))
    }()

    override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.setFillColor(UIColor.systemGreen.cgColor)
        let viewRect = CGRect(
            x: 0.0,
            y: triangleHeight,
            width: frame.width,
            height: frame.height - triangleHeight)
        let clipPath: CGPath = UIBezierPath(
            roundedRect: viewRect,
            cornerRadius: 8.0).cgPath
        context?.saveGState()
        context?.addPath(clipPath)
        context?.move(to: leftCorner)
        context?.addLine(to: topCorner)
        context?.addLine(to: rightCorner)
        context?.fillPath()
        setupViews()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        setNeedsDisplay()
    }

    private func setupViews() {
        self.addSubview(textLabel)
        textLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        textLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 8.0).isActive = true
        textLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 8.0).isActive = true
    }

    public func setText(_ text: String?) {
        textLabel.text = text
    }
}
