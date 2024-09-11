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
    
    var rockets: [[RocketCollectionModel.CellData]] = []
    
    private var rocketDataSource: DataSource?
    
	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

        setupRocketInfoCollectionView()
        setupRocketInfoCollectionDataSource()
        setupBehavior()
        addFooterHeader()
        
	}
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Task {
            await fetchData()
        }
    }
}

extension MainViewController: UICollectionViewDelegate {
    // MARK: - Setup Rocket Collection View
    
    private func setupRocketInfoCollectionView() {
        rootView.rocketInfoCollectionView.delegate = self
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
    
    func fetchData() async {
        let rocketSersvice = RocketSettingsService()
        let json: [String: Any] = [:]
        do {
            let decodedData = try await rocketSersvice.getRocketSettings(json: json)
            DispatchQueue.main.async {
                self.rockets = self.turnToRocketCollectionModel(decodedData)
                self.setupData(self.rockets[0])
            }
        } catch {
            print("Функция упала: \(error.localizedDescription)")
        }
    }
    
    func turnToRocketCollectionModel(_ decodedData: [RocketSettingsResponse]) -> [[RocketCollectionModel.CellData]] {
        var cellDataArray: [[RocketCollectionModel.CellData]] = []
        for decodedElement in decodedData {
            var cellData: [RocketCollectionModel.CellData] = [
                RocketCollectionModel.CellData(sectionNumber: 0, mainText: String(decodedElement.height.meters), secondaryText: TypeOfMeasurement.Height.description, unitsOfMeasurement: TypeOfMeasurement.Height.meters),
                RocketCollectionModel.CellData(sectionNumber: 0, mainText: String(decodedElement.diameter.meters), secondaryText: TypeOfMeasurement.Diameter.description, unitsOfMeasurement: TypeOfMeasurement.Diameter.meters),
                RocketCollectionModel.CellData(sectionNumber: 0, mainText: String(decodedElement.mass.kg), secondaryText: TypeOfMeasurement.Weight.description, unitsOfMeasurement: TypeOfMeasurement.Weight.kilograms),
                RocketCollectionModel.CellData(sectionNumber: 1, mainText: "Первый запуск", secondaryText: decodedElement.firstFlight, unitsOfMeasurement: nil),
                RocketCollectionModel.CellData(sectionNumber: 1, mainText: "Страна", secondaryText: decodedElement.country, unitsOfMeasurement: nil),
                RocketCollectionModel.CellData(sectionNumber: 1, mainText: "Стоимость", secondaryText: String(decodedElement.costPerLaunch), unitsOfMeasurement: "$"),
                RocketCollectionModel.CellData(sectionNumber: 2, mainText: "Количество двигателей",  secondaryText: String(decodedElement.firstStage.engines), unitsOfMeasurement: ""),
                RocketCollectionModel.CellData(sectionNumber: 2, mainText: "Количество топлива", secondaryText: String(decodedElement.firstStage.fuelAmountTons), unitsOfMeasurement: "ton"),
                RocketCollectionModel.CellData(sectionNumber: 3, mainText: "Количество двигателей",  secondaryText: String(decodedElement.secondStage.engines), unitsOfMeasurement: ""),
                RocketCollectionModel.CellData(sectionNumber: 3, mainText: "Количество топлива", secondaryText: String(decodedElement.secondStage.fuelAmountTons), unitsOfMeasurement: "ton")
            ]
            if let stageOneBurnTime = decodedElement.firstStage.burnTimeSec {
                let elem = RocketCollectionModel.CellData(sectionNumber: 2, mainText: "Время сгорания топлива", secondaryText: String(stageOneBurnTime), unitsOfMeasurement: "сек")
                cellData.append(elem)
            }
            if let stageTwoBurnTime = decodedElement.secondStage.burnTimeSec {
                let elem = RocketCollectionModel.CellData(sectionNumber: 3, mainText: "Время сгорания топлива", secondaryText: String(stageTwoBurnTime), unitsOfMeasurement: "сек")
                cellData.append(elem)
            }
            cellDataArray.append(cellData)
        }
        return cellDataArray
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
