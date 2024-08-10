//
//  MainView.swift
//  SpaceProject
//
//  Created by Захар Литвинчук on 10.08.2024.
//

import UIKit
import SnapKit

final class MainView: UIView {
	// MARK: - UI Components

	let baseLabel = UILabel()

	override init(frame: CGRect) {
		super.init(frame: frame)
		embedViews()
		setupAppearance()
		setupLayout()
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
		addSubviews(baseLabel)
	}

	// MARK: - Setup Appearance

	func setupAppearance() {
		backgroundColor = .cyan

		baseLabel.font = .systemFont(ofSize: 30, weight: .semibold)
		baseLabel.textColor = .black
		baseLabel.textAlignment = .center
	}

	// MARK: - Setup Layout

	func setupLayout() {
		baseLabel.snp.makeConstraints {
			$0.center.equalToSuperview()
		}
	}

	// MARK: - Setup Behavior

	func setupBehavior() {

	}

	// MARK: - Setup Data

	func setupData() {
	}
}
