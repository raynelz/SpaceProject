//
//  MainViewController.swift
//  SpaceProject
//
//  Created by Захар Литвинчук on 10.08.2024.
//

import UIKit

/// Контроллер главного экрана
final class MainViewController: GenericViewController<MainView> {
	// MARK: - Life Cycle

	override func viewDidLoad() {
		super.viewDidLoad()

		rootView.baseLabel.text = "PONYAL"
	}
}
