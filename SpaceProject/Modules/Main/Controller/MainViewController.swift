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
    
    private var rocketDataSource: DataSource?
    
    // Custom initializer to accept data
    init(data: [RocketCollectionModel.CellData]) {
        self.data = data
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

        setupRocketInfoCollectionView()
        setupRocketInfoCollectionDataSource()
        setupBehavior()
        addFooterHeader()
        
        setupData(data)
	}
}

extension MainViewController: UICollectionViewDelegate {
    // MARK: - Setup Rocket Collection View
    
    private func setupRocketInfoCollectionView() {
        rootView.rocketInfoCollectionView.delegate = self
    }
}

//MARK: - Public Methods

extension MainViewController {
    // MARK: Setup data
    
    func setupData(_ data: [RocketCollectionModel.CellData]) {
        print("Зашла")
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
    
    func addFooterHeader() {
        let headerRegistration = UICollectionView.SupplementaryRegistration<RocketCollectionHeaderView>(
            elementKind: RocketCollectionHeaderView.identifier
        ) { supplementaryView, _, _ in
            supplementaryView.delegate = self
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
        let sheetViewController = RocketSettingsViewController()
        let navigationController = UINavigationController(rootViewController: sheetViewController)
        if let sheet = navigationController.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
        }
        present(navigationController, animated: true)
    }
}
