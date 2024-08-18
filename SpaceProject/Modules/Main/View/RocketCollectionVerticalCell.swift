//
//  RocketCollectionVerticalCell.swift
//  SpaceProject
//
//  Created by Вадим Калинин on 17.08.2024.
//

import UIKit
import SnapKit

final class RocketCollectionVerticalCell: UICollectionViewCell {
    static let identifier = "RocketCollectionVerticalCell"
    
    // MARK: - UI Components
    let leftLabel = UILabel()
    let rightLabel = UILabel()
    
    // MARK: - View initializator
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        embedViews()
        setupAppearance()
        setupLayout()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - Private Methods

private extension RocketCollectionVerticalCell {
    // MARK: - Embed Views
    
    func embedViews() {
        addSubviews(
            leftLabel,
            rightLabel
        )
    }
    
    // MARK: - Setup Appearance
    
    func setupAppearance() {
        leftLabel.text = "LeftLabel"
        leftLabel.textColor = SpaceAppColor.cellText.darkVariant
        leftLabel.textAlignment = .left
        
        rightLabel.text = "RightLabel"
        rightLabel.textColor = SpaceAppColor.text.darkVariant
        rightLabel.textAlignment = .right
        
        [leftLabel, rightLabel].forEach {
            $0.font = .systemFont(ofSize: 15)
        }
    }
    
    // MARK: - Setup Layout
    
    func setupLayout() {
        leftLabel.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.centerY.equalToSuperview()
            $0.right.equalTo(rightLabel)
        }
        
        rightLabel.snp.makeConstraints {
            $0.right.equalToSuperview()
            $0.centerY.equalToSuperview()
        }
    }
}
