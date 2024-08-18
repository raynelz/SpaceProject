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
        addFooterHeader()
        addTestData()
	}
}

extension MainViewController: UICollectionViewDelegate {
    // MARK: - Setup Rocket Collection View

    func setupRocketInfoCollectionView() {
        rootView.rocketInfoCollectionView.delegate = self
    }
    
    // MARK: - Setup Collection DataSource
    
    func setupRocketInfoCollectionDataSource() {
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
            
            return self.rootView.rocketInfoCollectionView.dequeueReusableCell(
                withReuseIdentifier: cellIdentifier,
                for: indexPath
            )
        }
    }
    
    // MARK: - Add footer and header
    
    func addFooterHeader() {
        let headerRegistration = UICollectionView.SupplementaryRegistration
        <RocketCollectionHeaderView>(
            elementKind: UICollectionView.elementKindSectionHeader
        ) { _, _, _ in
            // Configure if needed
        }
        
        let footerRegistration = UICollectionView.SupplementaryRegistration
        <RocketCollectionFooterView>(
            elementKind: UICollectionView.elementKindSectionFooter
        ) { _, _, _ in
            // Configure if needed
        }
        
        rocketDataSource?.supplementaryViewProvider = { _, kind, index in
            if kind == UICollectionView.elementKindSectionFooter {
                return self.rootView.rocketInfoCollectionView.dequeueConfiguredReusableSupplementary(
                    using: footerRegistration,
                    for: index
                )
            } else {
                return self.rootView.rocketInfoCollectionView.dequeueConfiguredReusableSupplementary(
                    using: headerRegistration,
                    for: index
                )
            }
        }
    }
     
    // FIXME: Remove test data from VC
    func addTestData() {
        var snapshot = NSDiffableDataSourceSnapshot<MainView.SectionType, Int>()
        snapshot.appendSections([.specificationInfo, .additionalInfo, .firstStageInfo, .secondStageInfo])
        snapshot.appendItems([0, 1, 2, 3, 4, 5], toSection: .specificationInfo)
        snapshot.appendItems([6, 7, 8], toSection: .additionalInfo)
        snapshot.appendItems([9, 10, 11], toSection: .firstStageInfo)
        snapshot.appendItems([12, 13], toSection: .secondStageInfo)
        rocketDataSource?.apply(snapshot)
    }
}
