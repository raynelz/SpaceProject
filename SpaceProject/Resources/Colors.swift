//
//  Colors.swift
//  SpaceProject
//
//  Created by Вадим Калинин on 17.08.2024.
//

import UIKit

enum SpaceAppColor {
    struct ThemeColor {
        let darkVariant: UIColor
        let lightVariant: UIColor
    }
    static let backgroundSecondary = ThemeColor(
        darkVariant: UIColor(white: 10/255, alpha: 1),
        lightVariant: UIColor(white: 245/255, alpha: 1)
    )
    static let cellBackground = ThemeColor(
        darkVariant: UIColor(white: 27/255, alpha: 1),
        lightVariant: UIColor(white: 228/255, alpha: 1)
    )
    static let background = ThemeColor(
        darkVariant: UIColor.black,
        lightVariant: UIColor.white
    )
    static let textSecondary = ThemeColor(
        darkVariant: UIColor(white: 203/255, alpha: 1),
        lightVariant: UIColor(white: 52/255, alpha: 1)
    )
    static let cellText = ThemeColor(
        darkVariant: UIColor(white: 138/255, alpha: 1),
        lightVariant: UIColor(white: 117/255, alpha: 1)
    )
    static let text = ThemeColor(
        darkVariant: UIColor.white,
        lightVariant: UIColor.black
    )
}
