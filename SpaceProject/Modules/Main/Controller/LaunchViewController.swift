import UIKit

final class LaunchViewController: GenericViewController<LaunchView> {
    // MARK: - Properties
    
    private let launches = LaunchMockTest.launches
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupTableView()
    }
}

private extension LaunchViewController {
    // MARK: - Private Methods
    private func setupNavigationBar() {
        self.title = "Falcon Heavy"
        self.navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = SpaceAppColor.background
        self.navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: SpaceAppColor.textSecondary!
        ]
        self.navigationController?.navigationBar.tintColor = SpaceAppColor.background
        let leftButton = UIBarButtonItem (
            title: "Назад",
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
            
        )
        leftButton.tintColor = SpaceAppColor.textSecondary
        self.navigationItem.leftBarButtonItem = leftButton
    }
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
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
        cell.configure(model: launch)
        return cell
    }
}

// MARK: - UITableViewDelegate

extension LaunchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerView = UIView()
        footerView.backgroundColor = .clear
        footerView.frame = CGRect(x: 0, y: 0, width: tableView.frame.width, height: 1)
        return footerView
    }
}
