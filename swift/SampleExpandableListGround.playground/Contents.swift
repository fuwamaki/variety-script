import UIKit
import PlaygroundSupport

class ViewController: UITableViewController {

    private let items = [
        (type: "キュート", members: ["双葉", "緒方", "三村", "前川", "島村"]),
        (type: "クール", members: ["神崎", "多田", "アナ", "新田", "渋谷"]),
        (type: "パッション", members: ["諸星", "城ヶ崎", "赤城", "本田"]),
        (type: "ミシロ", members: ["美城"]),
    ]

    private var openedSections = Set<Int>()

    private func isContain(_ section: Int) -> Bool {
        return openedSections.contains(section)
    }

    @objc func sectionHeaderDidTap(_ sender: UIGestureRecognizer) {
        guard let section = sender.view?.tag else { return }
        if isContain(section) {
            openedSections.remove(section)
            print("close")
        } else {
            openedSections.insert(section)
            print("open")
        }
        tableView.reloadSections(IndexSet(integer: section), with: .fade)
    }
}

// MARK: TableViewDataSourse
extension ViewController {
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        cell.textLabel?.text = items[indexPath.section].members[indexPath.row]
        return cell
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isContain(section) ? items[section].members.count : 0
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }

    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        print(indexPath.row)
    }
}

// MARK: TableViewDelegate
extension ViewController {
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].type
    }

    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UITableViewHeaderFooterView()
        let gesture = UITapGestureRecognizer(target: self, action: #selector(sectionHeaderDidTap(_:)))
        view.addGestureRecognizer(gesture)
        view.tag = section
        return view
    }
}

PlaygroundPage.current.liveView = ViewController()
