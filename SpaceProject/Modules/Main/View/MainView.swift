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
    
    // FIXME: Change types location
    enum SectionType: Int, CaseIterable {
        case specificationInfo
        case additionalInfo
        case firstStageInfo
        case secondStageInfo
    }

    // MARK: - View initializator
	override init(frame: CGRect) {
		super.init(frame: frame)
        
		embedViews()
		setupAppearance()
		setupLayout()
        setupCollectionViewLayout()
		setupBehavior()
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
        backgroundImageView.backgroundColor = SpaceAppColor.backgroundSecondary.lightVariant
        
        bottomPageControl.backgroundColor = SpaceAppColor.backgroundSecondary.darkVariant
        bottomPageControl.numberOfPages = 1
        
        rocketInfoCollectionView.backgroundColor = SpaceAppColor.background.darkVariant
        rocketInfoCollectionView.layer.cornerRadius = 30
        rocketInfoCollectionView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]    }

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

	// MARK: - Setup Behavior

	func setupBehavior() {
        rocketInfoCollectionView.register(
            RocketCollectionVerticalCell.self,
            forCellWithReuseIdentifier: RocketCollectionVerticalCell.identifier
        )
        rocketInfoCollectionView.register(
            RocketCollectionHorizontalCell.self,
            forCellWithReuseIdentifier: RocketCollectionHorizontalCell.identifier
        )
	}

	// MARK: - Setup Data

	func setupData() {
	}
    
    // MARK: - Setup CollectionView Layout
    
    func setupCollectionViewLayout() {
        let layout = UICollectionViewCompositionalLayout { (sectionIndex, layoutEnvoirment) -> NSCollectionLayoutSection? in
            guard let sectionType = SectionType(rawValue: sectionIndex) else {
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
            
            // MARK: Section layout
            
            let section = NSCollectionLayoutSection(group: group)
            section.contentInsets = .init(top: 10, leading: 30, bottom: 10, trailing: 30)
            
            // TODO: Add sections text headers
            switch sectionIndex {
            case 0:
                let sectionHeader = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section.boundarySupplementaryItems = [sectionHeader]
                section.orthogonalScrollingBehavior = .continuous
            case (SectionType.allCases.count - 1):
                let sectionFooter = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: headerFooterSize,
                    elementKind: UICollectionView.elementKindSectionFooter,
                    alignment: .bottom
                )
                section.boundarySupplementaryItems = [sectionFooter]
            default:
                section.boundarySupplementaryItems = []
            }
            
            return section
        }
        
        rocketInfoCollectionView.collectionViewLayout = layout
    }
}
