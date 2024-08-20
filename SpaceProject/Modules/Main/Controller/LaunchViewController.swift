import UIKit

final class LaunchViewController: GenericViewController<LaunchView> {
    // MARK: - Properties

    private let launches = makeLaunches()

    // MARK: - Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    // MARK: - Private Methods

    private func setupTableView() {
        rootView.tableView.register(LaunchViewCell.self, forCellReuseIdentifier: "LaunchCell")
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
        rootView.tableView.reloadData()

    }
}

// MARK: - UITableViewDataSource

extension LaunchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        launches.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "LaunchCell", for: indexPath)
                as? LaunchViewCell else {
            fatalError("Ячейка не найдена")
        }

        let launch = launches[indexPath.section]
        cell.configure(with: launch.name, date: launch.date, isSuccess: launch.launchIs)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension LaunchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100 // Высота ячейки
    }
    
    
    
    // Задаем высоту отступа между ячейками через Footer
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 10 // Высота отступа между секциями
    }

    // Возвращаем пустое представление для Footer, чтобы создать отступ
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = UIColor.clear
        return footerView
    }
}
