
import UIKit
import PlaygroundSupport

// MARK: MyCollectionCell
final class MyCollectionCell: UICollectionViewCell {

    private lazy var label: UILabel = {
        let label = UILabel(frame: CGRect(x: 8, y: 0, width: 120, height: 48))
        label.text = "test"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        clipsToBounds = true
        contentView.addSubview(label)
        setup()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .systemOrange
        clipsToBounds = false
        layer.cornerRadius = 8.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.4
        layer.shadowRadius = 4.0
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
    }
}

// MARK: MyViewController
final class MyViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 240, height: 48)
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let collectionView = UICollectionView(frame: CGRect(x: 8, y: 8, width: 360, height: 360),
                                              collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .secondarySystemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(MyCollectionCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(collectionView)
        self.view = view
    }
}

// MARK: MyViewController: UICollectionViewDelegate
extension MyViewController: UICollectionViewDelegate {}

// MARK: MyViewController: UICollectionViewDataSource
extension MyViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        return 1
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        return cell
    }
}

PlaygroundPage.current.liveView = MyViewController()
