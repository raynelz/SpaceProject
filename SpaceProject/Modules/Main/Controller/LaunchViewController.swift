import UIKit

final class LaunchViewController: GenericViewController<LaunchView> {
    // MARK: - Properties
    
    private var launches: [LaunchesResponse] = []
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        setupBehavior()
        Task {
            await fetchData()
        }
    }
}

private extension LaunchViewController {
    // MARK: - Private Methods
    func setupNavigationBar() {
        title = "Rockets"
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barTintColor = SpaceAppColor.background
        navigationController?.navigationBar.titleTextAttributes = [
            .foregroundColor: SpaceAppColor.textSecondary!
        ]
        navigationController?.navigationBar.tintColor = SpaceAppColor.background
        
        let leftButton = UIBarButtonItem (
            title: "Назад",
            style: .plain,
            target: self,
            action: #selector(backButtonTapped)
            
        )
        leftButton.tintColor = SpaceAppColor.textSecondary
        navigationItem.leftBarButtonItem = leftButton
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    func setupBehavior() {
        rootView.tableView.register(LaunchViewCell.self, forCellReuseIdentifier: "LaunchCell")
        rootView.tableView.dataSource = self
        rootView.tableView.delegate = self
        rootView.tableView.reloadData()
    }
    func fetchData() async {
        let launchesService = LaunchesService()
        let json: [String: Any] = [:]
        do {
            let decodedData = try await launchesService.getLaunches(json: json)
            DispatchQueue.main.async {
                    self.launches = decodedData
                self.rootView.tableView.reloadData()
            }
        } catch {
            print("Функция упала: \(error.localizedDescription)")
        }
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
            return UITableViewCell()
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
