//
//  Colors.swift
//  SpaceProject
//
//  Created by Вадим Калинин on 17.08.2024.
//

import UIKit

/// Перечисление `SpaceAppColor` содержит статические свойства, представляющие цвета, используемые в приложении.
/// Эти цвета задают внешний вид различных элементов пользовательского интерфейса.
enum SpaceAppColor {
    /// Цвет для вторичных фонов.
    static let backgroundSecondary = UIColor(named: "BackgroundSecondaryColor")
    
    /// Цвет фона ячеек.
    static let cellBackground = UIColor(named: "CellBackgroundColor")
    
    /// Цвет для вторичных фонов ячеек.
    static let cellBackgroundSecondary = UIColor(named: "CellBackgroundSecondary")
    
    /// Основной фоновый цвет приложения.
    static let background = UIColor.systemBackground
    
    /// Основной цвет текста.
    static let text = UIColor.label
    
    /// Цвет текста для вторичных элементов.
    static let textSecondary = UIColor(named: "TextSecondaryColor")
    
    /// Цвет текста в ячейках.
    static let cellText = UIColor(named: "CellTextColor")
    
    /// Вторичный цвет текста в ячейках.
    static let cellTextSeconary = UIColor(named: "CellTextColorSecondary")
}

