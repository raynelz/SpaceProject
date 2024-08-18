//
//  RocketCollectionHeaderView.swift
//  SpaceProject
//
//  Created by Вадим Калинин on 17.08.2024.
//

import UIKit
import SnapKit

final class RocketCollectionHeaderView: UICollectionReusableView {
    // MARK: - UI Components
    let rocketNameLabel = UILabel()
    let settingsButton = UIButton()
    
    // MARK: - View initializator
    override init(frame: CGRect) {
        super.init(frame: frame)
        embedViews()
        setupAppearance()
        setupLayout()
        setupBehavior()
    }
    
    @available(*, unavailable)
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Private Methods

private extension RocketCollectionHeaderView {
    // MARK: - Embed Views
    
    func embedViews() {
        addSubviews(
            rocketNameLabel,
            settingsButton
        )
    }
    
    // MARK: - Setup Appearance
    
    func setupAppearance() {
        rocketNameLabel.font = .systemFont(ofSize: 25, weight: .semibold)
        // TODO: Add localization and color switch
        rocketNameLabel.textColor = SpaceAppColor.text.darkVariant
        rocketNameLabel.text = "Falcon Heavy"
        
        settingsButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingsButton.contentVerticalAlignment = .fill
        settingsButton.contentHorizontalAlignment = .fill
        // TODO: Add color switch
        settingsButton.tintColor = SpaceAppColor.cellText.lightVariant
    }
    
    // MARK: - Setup Layout

    func setupLayout() {
        rocketNameLabel.snp.makeConstraints {
            $0.left.equalToSuperview().inset(30)
            $0.bottom.equalToSuperview().inset(20)
            $0.top.equalToSuperview().offset(40)
            $0.right.lessThanOrEqualTo(settingsButton.snp.left)
        }
        
        settingsButton.snp.makeConstraints {
            $0.right.equalToSuperview().inset(30)
            $0.centerY.equalTo(rocketNameLabel.snp.centerY)
            $0.size.equalTo(35)
        }
    }
    
    // MARK: - Setup Behavior

    func setupBehavior() {
    }
}
