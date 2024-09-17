//
//  RocketCollectionHeaderView.swift
//  SpaceProject
//
//  Created by Вадим Калинин on 17.08.2024.
//

import UIKit
import SnapKit

/// Протокол для делегирования событий из RocketCollectionHeaderView.
protocol RocketCollectionHeaderViewDelegate: AnyObject {
    /// Уведомляет делегата о том, что кнопка настроек в хедере коллекции была нажата.
    func didTapSettingsButton()
}

/// HeaderView коллекции ракеты.
///
/// `RocketCollectionHeaderView` — это дополнительный элемент коллекции (header),
/// который отображается в верхней части секций коллекции. Он содержит кнопку настроек,
/// нажатие на которую уведомляет делегата через протокол `RocketCollectionHeaderViewDelegate`.
final class RocketCollectionHeaderView: UICollectionReusableView {
    /// Идентификатор для регистрации и повторного использования `RocketCollectionHeaderView` в коллекции.
    static let identifier = "RocketCollectionHeaderView"
    
    /// Делегат, который будет уведомлён о нажатии кнопки настроек.
    weak var delegate: RocketCollectionHeaderViewDelegate?
    
    // MARK: - UI Components
    /// Доступ к названию ракеты
    let rocketNameLabel = UILabel()
    private let settingsButton = UIButton()
    
    // MARK: - Initialization
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
        rocketNameLabel.textColor = SpaceAppColor.text
        rocketNameLabel.text = "Falcon Heavy"
        
        settingsButton.setImage(UIImage(systemName: "gearshape"), for: .normal)
        settingsButton.contentVerticalAlignment = .fill
        settingsButton.contentHorizontalAlignment = .fill
        settingsButton.tintColor = SpaceAppColor.cellText
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
        settingsButton.addTarget(self, action: #selector(navigateToSettings), for: .touchUpInside)
    }
    
    @objc
    func navigateToSettings() {
        settingsButton.animateTap()
        delegate?.didTapSettingsButton()
    }
}
