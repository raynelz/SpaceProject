//
//  MainView.swift
//  SpaceProject
//
//  Created by Zахар ЛитVинчук on 10.08.2024.
//

import UIKit
import SnapKit

final class MainView: UIView {
	// MARK: - UI Components
    let backgroundImageView = UIImageView()
    let bottomPageControl = UIPageControl()
    let rocketInfoCollectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewLayout())

    // MARK: - Initialization
	override init(frame: CGRect) {
		super.init(frame: frame)
        
		embedViews()
		setupAppearance()
		setupLayout()
        setupCollectionViewLayout()
		setupData()
	}

	@available(*, unavailable)
	required init?(coder: NSCoder) {
		fatalError("init(coder:) has not been implemented")
	}
}

// MARK: - Private Methods

private extension MainView {
	// MARK: - Embed Views

	func embedViews() {
        addSubviews(
            backgroundImageView,
            bottomPageControl,
            rocketInfoCollectionView
        )
	}

	// MARK: - Setup Appearance

	func setupAppearance() {
        // TODO: Add color switch by theme
        backgroundImageView.backgroundColor = SpaceAppColor.backgroundSecondary
        
        bottomPageControl.backgroundColor = SpaceAppColor.backgroundSecondary
        bottomPageControl.numberOfPages = 1
        
        rocketInfoCollectionView.backgroundColor = SpaceAppColor.background
        rocketInfoCollectionView.layer.cornerRadius = 30
        rocketInfoCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

	// MARK: - Setup Layout

	func setupLayout() {
        backgroundImageView.snp.makeConstraints {
            $0.horizontalEdges.top.equalToSuperview()
            $0.height.equalTo(300)
        }
        bottomPageControl.snp.makeConstraints {
            $0.horizontalEdges.bottom.equalToSuperview()
            $0.height.equalTo(80)
        }
        rocketInfoCollectionView.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview()
            $0.bottom.equalTo(bottomPageControl.snp.top)
            $0.top.equalTo(backgroundImageView.snp.bottom).offset(-30)
        }
	}

	// MARK: - Setup Data

	func setupData() {
	}
    
    // MARK: - Setup CollectionView Layout
    
    func setupCollectionViewLayout() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, _) -> NSCollectionLayoutSection? in
            guard let sectionType = RocketCollectionModel.SectionType(rawValue: sectionIndex) else {
                return nil
            }
            
            // MARK: Item layout
            
            let itemLayout = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)
            )
            let item = NSCollectionLayoutItem(layoutSize: itemLayout)
            item.contentInsets = .init(top: 5, leading: 5, bottom: 5, trailing: 5)
            
            // MARK: Group layout
            
            let group: NSCollectionLayoutGroup
            switch sectionType {
            case .specificationInfo:
                let groupLayout = NSCollectionLayoutSize(
                    widthDimension: .absolute(110),
                    heightDimension: .absolute(110)
                )
                group = NSCollectionLayoutGroup.horizontal(layoutSize: groupLayout, subitems: [item])
            default:
                let groupLayout = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                )
                group = NSCollectionLayoutGroup.vertical(layoutSize: groupLayout, subitems: [item])
            }
            
            // MARK: Header and Footer views layout
            
            let headerFooterSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(100)
            )
            
            let sectionNameSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1),
                heightDimension: .absolute(30)
            )
            
            // MARK: Section layout
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 10, leading: 30, bottom: 10, trailing: 30)
            
            switch sectionIndex {
            case 0:
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: RocketCollectionHeaderView.identifier,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [sectionHeader]
                section.orthogonalScrollingBehavior = .continuous
            case (RocketCollectionModel.SectionType.allCases.count - 1):
                let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: RocketCollectionFooterView.identifier,
                    alignment: .bottom
                )
                section.boundarySupplementaryItems = [sectionFooter]
            default:
                let sectionName = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: sectionNameSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .bottom
                )
                section.boundarySupplementaryItems = [sectionName]
            }
            
            return section
        }
        
        rocketInfoCollectionView.collectionViewLayout = layout
    }
}
