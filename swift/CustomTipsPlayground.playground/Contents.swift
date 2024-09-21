import UIKit
import PlaygroundSupport

// MARK: MyCollectionCell
final class MyCollectionCell: UICollectionViewCell {

    private lazy var label: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false // for AutoLayout
        label.textAlignment = .center
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemYellow
        contentView.addSubview(label)
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            label.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 4),
            label.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -4),
            label.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        fatalError("init(coder:) has not been implemented")
    }

    public func render(_ text: String) {
        label.text = text
    }
}

// MARK: CustomViewFlowLayout
class CustomViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        self.minimumLineSpacing = 4.0
        self.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let attributes = super.layoutAttributesForElements(in: rect)
        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }
            layoutAttribute.frame.origin.x = leftMargin
            leftMargin += layoutAttribute.frame.width + 4.0
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }
        return attributes
    }
}

// MARK: MyViewController
final class MyViewController: UIViewController {

    private let keywordList = [
        "ワンピース",
        "呪術廻戦",
        "アオのハコ",
        "正反対の君と僕",
        "あかね噺",
        "ふつうの軽音部",
        "僕のヒーローアカデミア",
        "スパイファミリー",
        "東京リベンジャーズ",
        "チェンソーマン",
        "進撃の巨人",
        "ハイキュー!!",
        "Dr.STONE",
        "ブルーロック",
        "約束のネバーランド",
        "ブラッククローバー",
        "ダンダダン",
        "鬼滅の刃",
        "キングダム",
        "ヒカルの碁"
    ]

    private let customViewFlowLayout = CustomViewFlowLayout()

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(
            frame: CGRect(x: 0, y: 0, width: 375, height: 600),
            collectionViewLayout: customViewFlowLayout
        )
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
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return keywordList.count
    }

    func numberOfSections(
        in collectionView: UICollectionView
    ) -> Int {
        return 1
    }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: "cell",
            for: indexPath
        ) as! MyCollectionCell
        cell.render(keywordList[indexPath.row])
        return cell
    }
}

// MARK: MyViewController: UICollectionViewFlowLayout
extension MyViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(
        _ collectionView: UICollectionView,
        layout collectionViewLayout: UICollectionViewLayout,
        sizeForItemAt indexPath: IndexPath
    ) -> CGSize {
        return CGSize(width: keywordList[indexPath.row].labelWidth(), height: 30)
    }
}

extension String {
    func labelWidth(fontSize: CGFloat = 14.0, extraSpace: CGFloat = 12.0) -> CGFloat {
        let fontAttribute = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize)]
        return self.size(withAttributes: fontAttribute).width + extraSpace
    }
}

// MARK: liveView
PlaygroundPage.current.liveView = MyViewController()
