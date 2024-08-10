//
//  UIView+AddSubviews.swift
//  SpaceProject
//
//  Created by Захар Литвинчук on 10.08.2024.
//

import UIKit

extension UIView {
	func addSubviews(_ views: UIView...) {
		views.forEach { addSubview($0) }
	}
}
