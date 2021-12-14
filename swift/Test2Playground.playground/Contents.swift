import UIKit
import PlaygroundSupport

// MARK: MyTableCell
final class MyTableCell: UITableViewCell {

    private lazy var label: UILabel = {
        return UILabel(frame: CGRect(x: 8, y: 0, width: 164, height: 48))
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
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

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: CGRect(x: 0, y: 0, width: 375, height: 600))
        tableView.backgroundColor = .secondarySystemBackground
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(MyTableCell.self, forCellReuseIdentifier: "cell")
        tableView.tableFooterView = UIView()
        return tableView
    }()

    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white
        view.addSubview(tableView)
        self.view = view
    }
}

// MARK: MyViewController: UITableViewDelegate
extension MyViewController: UITableViewDelegate {}

// MARK: MyViewController: UITableViewDataSource
extension MyViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MyTableCell
        cell.render(indexPath.row)
        return cell
    }
}

// MARK: liveView
PlaygroundPage.current.liveView = MyViewController()
