//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let button = UIButton(type: .system)
        button.frame = CGRect(x: 25, y: 75, width: 150, height: 50)
        button.setTitle("Tap here!", for: .normal)
        button.setTitleColor(UIColor.white, for: .normal)
        
        // 角丸で親しみやすく
        button.layer.cornerRadius = button.bounds.midY
        // 押せそうにみえる影
        button.layer.shadowColor = UIColor.startColor.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 3)
        button.layer.shadowOpacity = 0.7
        button.layer.shadowRadius = 10
        // グラデーションで強めのアピール (リサイズ非対応！）
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = button.bounds
        gradientLayer.cornerRadius = button.bounds.midY
        gradientLayer.colors = [UIColor.startColor.cgColor, UIColor.endColor.cgColor]
        gradientLayer.startPoint = CGPoint(x: 0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1, y: 0.5)

        button.layer.insertSublayer(gradientLayer, at: 0)

        view.addSubview(button)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()

extension UIColor {
    static var startColor: UIColor {
        return UIColor(hex: "eb5757")
    }

//    static var endColor: UIColor {
//        return UIColor(hex: "000000")
//    }

    static var endColor: UIColor {
        return UIColor(hex: "ff7878")
    }

    public convenience init(hex: String, alpha: CGFloat = 1.0) {
        let v = Int("000000" + hex, radix: 16) ?? 0
        let r = CGFloat(v / Int(powf(256, 2)) % 256) / 255
        let g = CGFloat(v / Int(powf(256, 1)) % 256) / 255
        let b = CGFloat(v / Int(powf(256, 0)) % 256) / 255
        self.init(red: r, green: g, blue: b, alpha: min(max(alpha, 0), 1))
    }
}
