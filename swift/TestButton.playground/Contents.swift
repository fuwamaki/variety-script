//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController {
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        let button = UIButton(frame: CGRect(x: 150, y: 400, width: 132, height: 32))
        button.backgroundColor = .green
        button.setTitle("message", for: .normal)
        button.layer.cornerRadius = 13.0
        button.layer.shadowOpacity = 0.5
        button.layer.shadowRadius = 3.0
        button.layer.shadowOffset = CGSize(width: 1, height: 1)
        button.layer.shadowColor = UIColor.systemGreen.cgColor
        
        view.addSubview(label)
        view.addSubview(button)
        self.view = view
    }
}
// Present the view controller in the Live View window
PlaygroundPage.current.liveView = MyViewController()
