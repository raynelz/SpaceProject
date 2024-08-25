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

extension UIView {
    func animateTap() {
        self.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        
        UIView.animate(
            withDuration: 0.5,
            delay: 0,
            usingSpringWithDamping: 0.5,
            initialSpringVelocity: 6,
            options: .allowUserInteraction
        ) {
            self.transform = CGAffineTransform(scaleX: 1, y: 1)
        }
    }
}
