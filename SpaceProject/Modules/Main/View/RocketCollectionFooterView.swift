//
//  RocketCollectionHeaderView.swift
//  SpaceProject
//
//  Created by Вадим Калинин on 17.08.2024.
//

import UIKit
import SnapKit

/// Протокол для делегирования событий из RocketCollectionFooterView.
protocol RocketCollectionFooterViewDelegate: AnyObject {
    /// Уведомляет делегата о том, что кнопка в футере коллекции была нажата.
    func didTapLaunchButton()
}

/// Вью футера для коллекции ракеты.
///
/// Включает кнопку, которая позволяет пользователю перейти к экрану запусков.
/// Передает события через делегат RocketCollectionFooterViewDelegate.
final class RocketCollectionFooterView: UICollectionReusableView {
    
    /// Идентификатор для повторного использования футера в коллекции.
    static let identifier = "RocketCollectionFooterView"
    
    /// Делегат для обработки нажатия кнопки "Посмотреть запуски".
    weak var delegate: RocketCollectionFooterViewDelegate?
    
    /// Для установки родительского контроллера (View Controller) для того чтобы дергать `NavigationController`.
    weak var viewController: UIViewController?

    // MARK: - UI Components
    private let launchesNavigationButton = UIButton()
    
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
private extension RocketCollectionFooterView {
    // MARK: - Embed Views
    
    func embedViews() {
        addSubviews(launchesNavigationButton)
    }
    
    // MARK: - Setup Appearance
    
    func setupAppearance() {
        launchesNavigationButton.setTitle("Посмотреть запуски", for: .normal)
        launchesNavigationButton.backgroundColor = SpaceAppColor.cellBackground
        launchesNavigationButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .semibold)
        launchesNavigationButton.setTitleColor(SpaceAppColor.text, for: .normal)
        launchesNavigationButton.layer.cornerRadius = 10
    }
    
    // MARK: - Setup Layout
    
    func setupLayout() {
        launchesNavigationButton.snp.makeConstraints {
            $0.horizontalEdges.equalToSuperview().inset(30)
            $0.verticalEdges.equalToSuperview().inset(25)
        }
    }

    // MARK: - Setup Behavior
    
    func setupBehavior() {
        launchesNavigationButton.addTarget(self, action: #selector(launchesButtonTapped), for: .touchUpInside)
    }
    
    @objc
    func launchesButtonTapped() {
        launchesNavigationButton.animateTap()
        delegate?.didTapLaunchButton()
    }
}
