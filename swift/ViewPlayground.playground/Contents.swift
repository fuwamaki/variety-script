import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {

    private lazy var contentView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.8
        view.layer.shadowRadius = 8.0
        view.layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        return view
    }()

    private lazy var imageView: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 28, y: 240, width: 320, height: 120))
        imageView.image = UIImage(named: "entertainment.jpg")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 13.0
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.red.cgColor
        return imageView
    }()

    override func loadView() {
        contentView.addSubview(imageView)
        self.view = contentView
    }
}

PlaygroundPage.current.liveView = MyViewController()
