import UIKit
import PlaygroundSupport

// MARK: MyCollectionCell
final class MyCollectionCell: UICollectionViewCell {

    private lazy var label: UILabel = {
        return UILabel(frame: CGRect(x: 8, y: 0, width: 164, height: 48))
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemYellow
        contentView.addSubview(label)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    public func render(_ index: Int) {
        label.text = String(index)
    }
}

// MARK: MyViewController
final class MyViewController: UIViewController {

    private lazy var collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .vertical
        flowLayout.itemSize = CGSize(width: 180, height: 48)
        flowLayout.sectionInset = UIEdgeInsets(top: 8, left: 2, bottom: 8, right: 2)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 0, width: 375, height: 600),
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
        return 5
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionCell
        cell.render(indexPath.row)
        return cell
    }
}

// MARK: liveView
PlaygroundPage.current.liveView = MyViewController()
