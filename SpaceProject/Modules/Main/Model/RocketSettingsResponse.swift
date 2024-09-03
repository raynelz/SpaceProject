//
//  RocketSettingsResponse.swift
//  SpaceProject
//
//  Created by Станислав Никулин on 03.09.2024.
//

/// Модель ответа API для отображения настроек ракеты в MainView.
struct RocketSettingsResponse: Decodable {
    /// Название ракеты.
    let name: String
    
    /// Стоимость запуска (в долларах).
    let costPerLaunch: Int
    
    /// Дата первого запуска ракеты (в формате строки).
    let firstFlight: String
    
    /// Страна, из которой происходит ракета.
    let country: String
    
    /// Высота ракеты.
    let height: Height
    
    /// Диаметр ракеты.
    let diameter: Diameter
    
    /// Масса ракеты.
    let mass: Mass
    
    /// Данные о первой ступени ракеты.
    let firstStage: FirstStage
    
    /// Данные о второй ступени ракеты.
    let secondStage: SecondStage
}

/// Модель данных о высоте ракеты.
struct Height: Decodable {
    /// Высота ракеты в метрах.
    let meters: Double
    
    /// Высота ракеты в футах.
    let feet: Double
}

/// Модель данных о диаметре ракеты.
struct Diameter: Decodable {
    /// Диаметр ракеты в метрах.
    let meters: Double
    
    /// Диаметр ракеты в футах.
    let feet: Double
}

/// Модель данных о массе ракеты.
struct Mass: Decodable {
    /// Масса ракеты в килограммах.
    let kg: Double
    
    /// Масса ракеты в фунтах.
    let lb: Double
}

/// Модель данных о первой ступени ракеты.
struct FirstStage: Decodable {
    /// Количество двигателей на первой ступени.
    let engines: Int
    
    /// Объем топлива на первой ступени (в тоннах).
    let fuelAmountTons: Double
    
    /// Время горения первой ступени (в секундах).
    let burnTimeSec: Int
}

/// Модель данных о второй ступени ракеты.
struct SecondStage: Decodable {
    /// Количество двигателей на второй ступени.
    let engines: Int
    
    /// Объем топлива на второй ступени (в тоннах).
    let fuelAmountTons: Double
    
    /// Время горения второй ступени (в секундах).
    let burnTimeSec: Int
}
