//
//  MainViewController.swift
//  SpaceProject
//
//  Created by Захар Литвинчук on 10.08.2024.
//

import UIKit

/// Контроллер главного экрана
final class MainViewController: GenericViewController<MainView> {
    var rocketDataSource: UICollectionViewDiffableDataSource<MainView.SectionType, Int>?
    
	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

        setupRocketInfoCollectionView()
        setupRocketInfoCollectionDataSource()
        setupBehavior()
        addFooterHeader()
        addTestData()
	}
}

extension MainViewController: UICollectionViewDelegate {
    // MARK: - Setup Rocket Collection View

    func setupRocketInfoCollectionView() {
        rootView.rocketInfoCollectionView.delegate = self
    }
    
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
    
    private func setupRocketInfoCollectionDataSource() {
        rocketDataSource = UICollectionViewDiffableDataSource<MainView.SectionType, Int>(
            collectionView: rootView.rocketInfoCollectionView
        ) { _, indexPath, itemIdentifier in
            // TODO: Change info in cells by data
            let cellIdentifier: String
            
            switch indexPath.section {
            case 0:
                cellIdentifier = RocketCollectionHorizontalCell.identifier
            default:
                cellIdentifier = RocketCollectionVerticalCell.identifier
            }
            
            let cell = self.rootView.rocketInfoCollectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier,
                for: indexPath
            )
            if let cell = cell as? RocketCollectionVerticalCell, indexPath.section > 1 {
                cell.cellType = 1
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
            let sectionName = UILabel()
            sectionName.text = MainView.SectionType(rawValue: indexPath.section + 1)?.sectionName.uppercased()
            sectionName.font = .systemFont(ofSize: 20, weight: .semibold)
            sectionName.textColor = .white
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
     
    // FIXME: Remove test data from VC
    private func addTestData() {
        var snapshot = NSDiffableDataSourceSnapshot<MainView.SectionType, Int>()
        snapshot.appendSections([.specificationInfo, .additionalInfo, .firstStageInfo, .secondStageInfo])
        snapshot.appendItems([0, 1, 2, 3, 4, 5], toSection: .specificationInfo)
        snapshot.appendItems([6, 7, 8], toSection: .additionalInfo)
        snapshot.appendItems([9, 10, 11], toSection: .firstStageInfo)
        snapshot.appendItems([12, 13], toSection: .secondStageInfo)
        rocketDataSource?.apply(snapshot)
    }
}
