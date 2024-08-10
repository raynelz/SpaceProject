//
//  GenericViewController.swift
//  SpaceProject
//
//  Created by Захар Литвинчук on 10.08.2024.
//

import UIKit

class GenericViewController<T: UIView>: UIViewController {
	// MARK: Public Properties

	var rootView: T {
		guard let rootView = view as? T else {
			fatalError("Failde to cast view as \(T.self)")
		}
		return rootView
	}

	// MARK: - Public Methods

	override func loadView() {
		self.view = T()
	}
}
