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
    
    private var rocketDataSource: DataSource?
    
	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

        setupRocketInfoCollectionView()
        setupRocketInfoCollectionDataSource()
        setupBehavior()
        addFooterHeader()
        
        setupData(MockData.collectionMockData)
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

    private func setupBehavior() {
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
    
    private func setupRocketInfoCollectionDataSource() {
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
    
    private func addFooterHeader() {
        let headerRegistration = UICollectionView.SupplementaryRegistration<RocketCollectionHeaderView>(
            elementKind: RocketCollectionHeaderView.identifier
        ) { supplementaryView, _, _ in
            supplementaryView.viewController = self
        }
        
        let footerRegistration = UICollectionView.SupplementaryRegistration<RocketCollectionFooterView>(
            elementKind: RocketCollectionFooterView.identifier
        ) { supplementaryView, _, _ in
            supplementaryView.viewController = self
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
