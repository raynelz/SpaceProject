//
//  MainViewController.swift
//  SpaceProject
//
//  Created by Захар Литвинчук on 10.08.2024.
//

import UIKit


/// Контроллер главного экрана
final class MainViewController: GenericViewController<MainView> {
    private typealias DataSource = UICollectionViewDiffableDataSource<
        RocketCollectionModel.SectionType,
        RocketCollectionModel.CellData
    >
    private typealias DataSnapshot = NSDiffableDataSourceSnapshot<
        RocketCollectionModel.SectionType,
        RocketCollectionModel.CellData
    >
    
    private let data: [RocketCollectionModel.CellData]
    private let rocketName: String
    private let imageURL: String
    private var rocketDataSource: DataSource?
    private let rocketSettingsVC = RocketSettingsViewController()
    
    // Кастомный инициализатор для правильного получения данных с сервера
    init(data: [RocketCollectionModel.CellData], headerData: RocketCollectionModel.HeaderData) {
        self.data = data
        self.rocketName = headerData.rocketName
        self.imageURL = headerData.image
        super.init(nibName: nil, bundle: nil)
    }
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

        setupRocketInfoCollectionView()
        setupRocketInfoCollectionDataSource()
        setupBehavior()
        addFooterHeader(rocketNameFromResponse: rocketName)
        downloadImage(from: imageURL)
        setupRocketVCDelegate()
        
        setupData(data)
	}
}

extension MainViewController: UICollectionViewDelegate {
    // MARK: - Setup Rocket Collection View
    
    private func setupRocketInfoCollectionView() {
        rootView.rocketInfoCollectionView.delegate = self
    }
}

// MARK: - Public Methods

extension MainViewController {
    // MARK: Setup data
    func setupData(_ data: [RocketCollectionModel.CellData]) {
        var snapshot = DataSnapshot()
        snapshot.appendSections(RocketCollectionModel.SectionType.allCases)
        data.forEach {
            guard let section = RocketCollectionModel.SectionType(rawValue: $0.sectionNumber) else {
                fatalError("Error! Incorrect section index!")
            }
            snapshot.appendItems([$0], toSection: section)
        }
        rocketDataSource?.apply(snapshot)
    }
}

// MARK: - Private Methods

private extension MainViewController {
    // MARK: - Setup Behavior

    func setupBehavior() {
        rootView.rocketInfoCollectionView.register(
            RocketCollectionVerticalCell.self,
            forCellWithReuseIdentifier: RocketCollectionVerticalCell.identifier
        )
        rootView.rocketInfoCollectionView.register(
            RocketCollectionHorizontalCell.self,
            forCellWithReuseIdentifier: RocketCollectionHorizontalCell.identifier
        )
    }
    
    // MARK: - Setup Collection DataSource
    
    func setupRocketInfoCollectionDataSource() {
        rocketDataSource = DataSource(
            collectionView: rootView.rocketInfoCollectionView
        ) { _, indexPath, itemData in
            let cellIdentifier: String
            
            switch itemData.sectionNumber {
            case 0:
                cellIdentifier = RocketCollectionHorizontalCell.identifier
            default:
                cellIdentifier = RocketCollectionVerticalCell.identifier
            }
            
            let cell = self.rootView.rocketInfoCollectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier,
                for: indexPath
            )
            
            if let cell = cell as? RocketCollectionVerticalCell {
                cell.setupData(itemData)
            } else if let cell = cell as? RocketCollectionHorizontalCell {
                cell.setupData(itemData)
            }
            
            return cell
        }
    }
    
    // MARK: - Add footer and header
    
    func addFooterHeader(rocketNameFromResponse: String) {
        let headerRegistration = UICollectionView.SupplementaryRegistration<RocketCollectionHeaderView>(
            elementKind: RocketCollectionHeaderView.identifier
        ) { supplementaryView, _, _ in
            supplementaryView.delegate = self
            supplementaryView.rocketNameLabel.text = rocketNameFromResponse
        }
        
        let footerRegistration = UICollectionView.SupplementaryRegistration<RocketCollectionFooterView>(
            elementKind: RocketCollectionFooterView.identifier
        ) { supplementaryView, _, _ in
            supplementaryView.delegate = self
        }
        
        let sectionNameRegistration = UICollectionView.SupplementaryRegistration<UICollectionReusableView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { supplementaryView, _, indexPath in
            let sectionName = {
                let sectionNameLabel = UILabel()
                sectionNameLabel.text = RocketCollectionModel
                    .SectionType(rawValue: indexPath.section + 1)?
                    .sectionName
                    .uppercased()
                sectionNameLabel.font = .systemFont(ofSize: 20, weight: .semibold)
                sectionNameLabel.textColor = SpaceAppColor.text
                return sectionNameLabel
            }()
            
            supplementaryView.addSubview(sectionName)
            
            sectionName.snp.makeConstraints {
                $0.edges.equalToSuperview()
            }
        }
        
        rocketDataSource?.supplementaryViewProvider = { _, kind, index in
            switch kind {
            case RocketCollectionFooterView.identifier:
                return self.rootView.rocketInfoCollectionView.dequeueConfiguredReusableSupplementary(
                    using: footerRegistration,
                    for: index
                )
            case RocketCollectionHeaderView.identifier:
                return self.rootView.rocketInfoCollectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration,
                    for: index
                )
            default:
                return self.rootView.rocketInfoCollectionView.dequeueConfiguredReusableSupplementary(
                    using: sectionNameRegistration,
                    for: index
                )
            }
        }
    }
    
    // MARK: - Fetch Data For Image View
    
    func downloadImage(from url: String) {
        let url = URL(string: url)!
        print("Download Started")
        getData(from: url) { data, response, error in
            guard let data = data, error == nil else { return }
            print(response?.suggestedFilename ?? url.lastPathComponent)
            print("Download Finished")
            // always update the UI from the main thread
            DispatchQueue.main.async { [weak self] in
                self?.rootView.backgroundImageView.image = UIImage(data: data)
            }
        }
    }
    func getData(from url: URL, completion: @escaping (Data?, URLResponse?, Error?) -> Void) {
        URLSession.shared.dataTask(with: url, completionHandler: completion).resume()
    }
    
    // MARK: Setup RocketSettings VC Delegate
    func setupRocketVCDelegate() {
        rocketSettingsVC.delegate = self
    }
}

/// Расширение для обработки событий нажатия кнопки в RocketCollectionFooterView
///
/// Реализует протокол `RocketCollectionFooterViewDelegate`, который отвечает за реакцию на нажатие кнопки
/// в футере коллекции. Делегат вызывает метод `didTapLaunchButton`, который инициирует переход на экран с запусками.
extension MainViewController: RocketCollectionFooterViewDelegate {

    /// Метод, вызываемый при нажатии кнопки в футере коллекции ракет.
    ///
    /// Открывает экран с информацией о запусках.
    func didTapLaunchButton() {
        let launchesVC = LaunchViewController()
        navigationController?.pushViewController(launchesVC, animated: true)
    }
}

/// Расширение для обработки событий нажатия кнопки в RocketCollectionHeaderView
///
/// Реализует протокол `RocketCollectionHeaderViewDelegate`, который отвечает за реакцию на нажатие кнопки
/// в хедере коллекции. Делегат вызывает метод `didTapSettingsButton`, который открывает окно настроек.
extension MainViewController: RocketCollectionHeaderViewDelegate {

    /// Метод, вызываемый при нажатии кнопки настроек в хедере коллекции.
    ///
    /// Открывает окно настроек в формате `sheet presentation` 
    /// с возможностью выбора между средним и большим представлением.
    func didTapSettingsButton() {
        let navigationController = UINavigationController(rootViewController: rocketSettingsVC)
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(navigationController, animated: true)
    }
}

extension MainViewController: RocketSettingsViewControllerDelegate {
    func didSettingsChange(diameterStatus: Bool, heightStatus: Bool, weightStatus: Bool) {
        print("Settings changed")
    }
}
