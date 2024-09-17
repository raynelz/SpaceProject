//
//  RocketSettings.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 22.08.2024.
//

import UIKit

/// Тип измерения для параметров ракеты.
/// Перечисление типов измерений
///
/// Содержит вложенные перечисления для высоты и веса, а также соответствующие единицы измерения.
enum TypeOfMeasurement {
    
    /// Перечисление для измерений высоты
    ///
    /// Содержит описание и единицы измерения для высоты: метры и футы.
    enum Height {
        /// Описание измерения высоты
        static let description = "Высота"
        /// Единица измерения высоты: метры
        static let meters = "m"
        /// Единица измерения высоты: футы
        static let feet = "ft"
    }
    /// Перечисление для измерений веса
    ///
    /// Содержит описание и единицы измерения для веса: килограммы и фунты.
    enum Weight {
        /// Описание измерения веса
        static let description = "Вес"
        /// Единица измерения веса: килограммы
        static let kilograms = "kg"
        /// Единица измерения веса: фунты
        static let pounds = "lb"
    }
    /// Перечисление для измерений Диаметра
    ///
    /// Содержит описание и единицы измерения для высоты: метры и футы.
    enum Diameter {
        /// Описание измерения веса
        static let description = "Диаметр"
        /// Единица измерения высоты: метры
        static let meters = "m"
        /// Единица измерения высоты: футы
        static let feet = "ft"
    }
}

/// Структура для удобного получения всех UISegment Controls
/// из экрана RocketSettingsView
struct SegmentedControlsModel {
    /// Парметры высоты m/ft
    let height: UISegmentedControl
    /// Параметры диаметра m/ft
    let diameter: UISegmentedControl
    /// Параметры веса kg/lb
    let weight: UISegmentedControl
}
